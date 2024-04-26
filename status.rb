# typed: strict

require_relative './help_text'
require_relative './git_file'
require_relative './staged_file'
require_relative './unstaged_file'
require_relative './untracked_file'
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
    system('clear')

    prompt = T.let(TTY::Prompt.new(symbols: { cross: '' }), TTY::Prompt)

    action = T.let(nil, T.nilable(StatusEventType))

    prompt.on(:keypress) do |event|
      if event.value == "j"
        prompt.trigger(:keydown)
      end
    
      if event.value == "k"
        prompt.trigger(:keyup)
      end

      if event.value == "a"
        if action == StatusEventType::CPressed
          action = StatusEventType::Amend
        else
          action = StatusEventType::Add
        end

        prompt.trigger(:keyenter)
      end

      if event.value == "A"
        action = StatusEventType::AddAll

        prompt.trigger(:keyenter)
      end

      if event.value == "u"
        action = StatusEventType::Unstage

        prompt.trigger(:keyenter)
      end

      if event.value == "c"
        if action == StatusEventType::CPressed
          action = StatusEventType::Commit
          prompt.trigger(:keyenter)
        else
          action = StatusEventType::CPressed
        end
      end

      if event.value == "d"
        action = StatusEventType::DPressed
      end

      if event.value == "v"
        if action == StatusEventType::DPressed
          action = StatusEventType::DiffView

          prompt.trigger(:keyenter)
        end
      end

      if event.value == "X"
        action = StatusEventType::Checkout

        prompt.trigger(:keyenter)
      end
    end

    all_files = added + unstaged_files + untracked_files

    if all_files.empty?
      puts "nothing to commit, working tree clean"
      return
    end

    all_sections = T.let([], T::Array[HelpText])

    help_text = HelpText.new
    help_text.text = <<-HELP
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
    all_sections << help_text

    container = HelpText.new("Git Status")
    container.border = HelpText::BorderType::Top
    
    help_text.top = container.padding
    help_text.left = container.padding
    
    git_output = GitOutput.new
    
    if git_output.has_changes?
      if unstaged_files.any?
        unstaged_files_section = HelpText.new("Changes not staged for commit:")
        unstaged_files.each do |file|
          unstaged_files_section << "modified: #{file.file_path}"
        end
        
        unstaged_files_section.border = HelpText::BorderType::Top
        unstaged_files_section.top = all_sections.sum(&:height) + (all_sections.size * container.padding)
        unstaged_files_section.left = container.padding
        unstaged_files_section.margin_width(1)
        unstaged_files_section.height *= 2
        
        all_sections << unstaged_files_section
      end
    end
    
    container.height = all_sections.sum(&:height) + (all_sections.size * container.padding)
    container.puts_frame
    all_sections.each(&:puts_frame)

    # options = HelpText.new

    # options.margin_width(1)
    # options.top = help_text.padding
    # options.left = help_text.padding
    # options.text = "On branch main"

    # options.puts_frame

    # file = prompt.select(
    #   "Git Status", 
    #   per_page: all_files.size + 3
    # ) do |menu|
    #   if added.any?
    #     menu.choice "Added", 'disabled', disabled: ''
    #     added.each do |file|
    #       menu.choice pastel.green(file.file_path), file
    #     end
    #   end

    #   if unstaged_files.any?
    #     menu.choice "Changes not staged for commit:", 'disabled', disabled: ''
    #     unstaged_files.each do |file|
    #       menu.choice pastel.red(file.file_path), file
    #     end
    #   end

    #   if untracked_files.any?
    #     menu.choice "Untracked files:", 'disabled', disabled: ''
    #     untracked_files.each do |file|
    #       menu.choice pastel.red(file.file_path), file
    #     end
    #   end
    # end

    # file = T.cast(file, T.any(StagedFile, UnstagedFile, UntrackedFile))

    # case action
    # when StatusEventType::Unstage
    #   file.unstage if file.is_a? StagedFile
    # when StatusEventType::Add
    #   file.add if file.is_a? UnstagedFile
    # when StatusEventType::AddAll
    #   `git add .`
    # when StatusEventType::Commit
    #   `git commit`
    # when StatusEventType::Amend
    #   `git commit --amend`
    # when StatusEventType::DiffView
    #   file.puts_diff
    # when StatusEventType::Checkout
    #   file.checkout
    # else
    #   file.open_in_editor
    # end

    # file_index = T.must(all_files.find_index(file))

    # file_to_puts = all_files[file_index + 1] || all_files[file_index - 1]

    # Status.new.puts_status(file_to_puts)
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