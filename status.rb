# typed: strict

require_relative './git_file'
require_relative './help_text'
require_relative './menu_item'
require_relative './staged_file'
require_relative './text_box'
require_relative './unstaged_file'
require_relative './untracked_file'

require 'io/console'
require 'pastel'
require 'tty-box'

class StatusEventType < T::Enum
  enums do
    Unstage = new
    Add = new
    AddAll = new
    Commit = new
    Amend = new
    DiffView = new
    Checkout = new
    CPressed = new
    DPressed = new
  end
end

class Status
  class GitOutput
    sig { void }
    def initialize
      @output = T.let(`git status`, String)
    end

    sig { returns(T.nilable(String)) }
    def branch_line
      output.split("\n").find { |line| line.start_with?("On branch") }
    end

    sig { returns(T.nilable(String)) }
    def relative_info_line
      output.split("\n").find { |line| line.start_with?("Your branch is") }
    end

    sig { returns(T::Boolean) }
    def has_changes?
      !output.split("\n").include?("nothing to commit")
    end

    private

    sig { returns(String) }
    attr_reader :output
  end

  sig { returns(Pastel::Delegator) }
  attr_reader :pastel

  sig { void }
  def initialize
    @pastel = T.let(Pastel.new, Pastel::Delegator)
  end

  sig { params(default: T.nilable(GitFile)).void }
  def puts_status(default = nil)
    print "\e[?25l"
    all_files = added + unstaged_files + untracked_files
    default ||= all_files.first

    if all_files.empty?
      puts "nothing to commit, working tree clean"
      return
    end
    
    container = HelpText.new("Git Status")
    container.border = HelpText::BorderType::Top

    help_text = TextBox.new(<<-HELP, container:)
j/k: scroll up/down
a: add
u: unstage
enter: open file
dv: open diff editor for file
cc: commit
ca: amend commit
X: checkout file
    HELP

    help_text.border = HelpText::BorderType::None
    help_text.margin_width(1)

    container.puts_frame

    git_output = GitOutput.new

    if !git_output.has_changes?
      TextBox.new("nothing to commit, working tree clean", container:)
    else
      if added.any?
        TextBox.new("Changes to be committed", container:)

        added.each do |file|
          MenuItem.new("  " + pastel.green(file.file_path), container:, selected: file == default)
        end
      end

      if unstaged_files.any?
        TextBox.new("Changes not staged for commit:", container:)

        unstaged_files.each do |file|
          MenuItem.new("  " + pastel.red(file.file_path), container:, selected: file == default)
        end
      end

      if untracked_files.any?
        TextBox.new("Untracked files:", container:)

        untracked_files.each do |file|
          MenuItem.new("  " + pastel.red(file.file_path), container:, selected: file == default)
        end
      end
    end

    container.all_sections.each(&:puts_frame)

    default_index = all_files.find_index(default) || 0

    ARGV.clear

    input = T.unsafe(STDIN).getch

    case input
    when "j"
      puts_status(all_files[default_index + 1] || all_files[default_index])
    when "k"
      puts_status(all_files[[default_index - 1, 0].max])
    when "a"
      if default.is_a?(UnstagedFile)
        default.add
      end

      system('clear')
      Status.new.puts_status
    when "u"
      if default.is_a?(StagedFile)
        default.unstage
      end

      system('clear')
      Status.new.puts_status
    when "\u0003"
      puts "Exiting..."
      system('clear')
    end
  end

  sig { returns(T::Array[StagedFile]) }
  def added
    @added ||= T.let(begin
      output = `git diff --name-only --cached`
      output.split("\n")
        .map(&:strip)
        .map { |file_path| StagedFile.new(file_path:) }
    end, T.nilable(T::Array[StagedFile]))
  end

  sig { returns(T::Array[UnstagedFile]) }
  def unstaged_files
    @unstaged_files ||= T.let(begin
    output = `git diff --name-only`
    output.split("\n")
      .map(&:strip)
      .map { |file_path| UnstagedFile.new(file_path:) }
    end, T.nilable(T::Array[UnstagedFile]))
  end

  sig { returns(T::Array[UntrackedFile]) }
  def untracked_files
    @untracked_files ||= T.let(`git ls-files --others --exclude-standard`.split("\n")
      .map(&:strip)
      .map { |file_path| UntrackedFile.new(file_path:) }, T.nilable(T::Array[UntrackedFile]))
  end
end