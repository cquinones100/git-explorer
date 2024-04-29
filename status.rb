# typed: strict

require_relative './git_file'
require_relative './help_text'
require_relative './menu_item'
require_relative './screen'
require_relative './staged_file'
require_relative './text_box'
require_relative './unstaged_file'
require_relative './untracked_file'

require 'io/console'
require 'pastel'

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
      @added_files = T.let(nil, T.nilable(T::Array[StagedFile]))
      @unstaged_files = T.let(nil, T.nilable(T::Array[UnstagedFile]))
      @untracked_files = T.let(nil, T.nilable(T::Array[UntrackedFile]))
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

    sig { returns(String) }
    def raw
      output
    end

    sig { returns(String) }
    def intro
      output
        .split("\n")
        .take_while do |line|
          !line.include?("Changes to be committed") &&
          !line.include?("Changes not staged for commit") &&
          !line.include?("Untracked files")
        end
        .join("\n")
    end

    sig { returns(T::Array[StagedFile]) }
    def added_files
      return @added_files if @added_files

      output = `git diff --name-only --cached`
      @added_files = output.split("\n")
        .map(&:strip)
        .map { |file_path| StagedFile.new(file_path:) }
    end

    sig { returns(T::Array[UnstagedFile]) }
    def unstaged_files
      return @unstaged_files if @unstaged_files

      output = `git diff --name-only`
      @unstaged_files = output.split("\n")
        .map(&:strip)
        .map { |file_path| UnstagedFile.new(file_path:) }
    end

    sig { returns(T::Array[UntrackedFile]) }
    def untracked_files
      return @untracked_files if @untracked_files

      @untracked_files = 
        `git ls-files --others --exclude-standard`.split("\n")
        .map(&:strip)
        .map { |file_path| UntrackedFile.new(file_path:) }
    end

    private

    sig { returns(String) }
    attr_reader :output
  end

  HELP_TEXT = <<-HELP_TEXT
j/k: scroll up/down
a: add
u: unstage
enter: open file
dv: open diff editor for file
cc: commit
ca: amend commit
X: checkout file
  HELP_TEXT

  sig { returns(Pastel::Delegator) }
  attr_reader :pastel

  sig { returns(Screen) }
  attr_reader :screen

  sig { void }
  def initialize
    @pastel = T.let(Pastel.new, Pastel::Delegator)
    @screen = T.let(Screen.new, Screen)
    @current_file_index = T.let(0, Integer)
    @all_file_lines = T.let([], T::Array[String])
  end

  sig { params(default: T.nilable(GitFile)).void }
  def puts_status(default = nil)
    screen.on_tick do |input|
      case input
      when "j"
        self.current_file_index = [self.current_file_index + 1, all_file_lines.length - 1].min

        screen.cursor_position = T.must(screen.buffer.index(T.must(all_file_lines[self.current_file_index])))
      when "k"
        self.current_file_index = [self.current_file_index - 1, 0].max

        screen.cursor_position = T.must(screen.buffer.index(T.must(all_file_lines[self.current_file_index])))
      when "a"
        file = self.all_file_lines[self.current_file_index]

        file = T.must(file).gsub(/\e\[[0-9;]*[a-zA-Z]/, '')

        system("git add #{file}")

        self.draw_buffer
      when "u"
        file = self.all_file_lines[self.current_file_index]

        file = T.must(file).gsub(/\e\[[0-9;]*[a-zA-Z]/, '')

        `git reset #{file}`

        self.draw_buffer
      end
    end

    draw_buffer

    screen.start
  rescue => e
    screen.reset
    raise e
  end

  private

  sig { void }
  def draw_buffer
    self.all_file_lines = []
    git_output = GitOutput.new
    buffer = T.let("", String)

    buffer += HELP_TEXT
    buffer += "\n"
    buffer += git_output.intro

    if git_output.added_files.any?
      buffer += "\nChanges to be committed\n" 

      git_output.added_files.each do |file|
        file_line = "  #{pastel.green(file.file_path)}\n"
        buffer += file_line
        all_file_lines << file_line
      end
    end

    if git_output.unstaged_files.any?
      buffer += "\nChanges not staged for commit:\n"

      git_output.unstaged_files.each do |file|
        file_line = "  #{pastel.red(file.file_path)}\n"
        buffer += file_line
        all_file_lines << file_line
      end
    end

    if git_output.untracked_files.any?
      buffer += "\nUntracked files:\n"
      git_output.untracked_files.each do |file|
        file_line = "  #{pastel.red(file.file_path)}\n"
        buffer += file_line
        all_file_lines << file_line
      end
    end

    screen.buffer = buffer

    if all_file_lines.any?
      current_file = T.must(all_file_lines[current_file_index])

      screen.cursor_position = T.must(screen.buffer.index(current_file))
    end
  end

  sig { returns(Integer)}
  attr_reader :current_file_index

  sig { params(current_file_index: Integer).void }
  attr_writer :current_file_index

  sig { returns(T::Array[String]) }
  attr_reader :all_file_lines

  sig { params(all_file_lines: T::Array[String]).void }
  attr_writer :all_file_lines
end