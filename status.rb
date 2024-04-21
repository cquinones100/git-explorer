# typed: strict

require_relative './git_file'
require_relative './staged_file'
require_relative './unstaged_file'
require_relative './untracked_file'
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

    file = prompt.select(
      "Git Status", 
      per_page: all_files.size + 3
    ) do |menu|
      menu.help <<-HELP

j/k: scroll up/down
a: add
u: unstage
enter: open file
dv: open diff editor for file
cc: commit
ca: amend commit
X: checkout file
      HELP
      if added.any?
        menu.choice "Added", 'disabled', disabled: ''
        added.each do |file|
          menu.choice pastel.green(file.file_path), file
        end
      end

      if unstaged_files.any?
        menu.choice "Changes not staged for commit:", 'disabled', disabled: ''
        unstaged_files.each do |file|
          menu.choice pastel.red(file.file_path), file
        end
      end

      if untracked_files.any?
        menu.choice "Untracked files:", 'disabled', disabled: ''
        untracked_files.each do |file|
          menu.choice pastel.red(file.file_path), file
        end
      end
    end

    file = T.cast(file, T.any(StagedFile, UnstagedFile, UntrackedFile))

    case action
    when StatusEventType::Unstage
      file.unstage if file.is_a? StagedFile
    when StatusEventType::Add
      file.add if file.is_a? UnstagedFile
    when StatusEventType::AddAll
      `git add .`
    when StatusEventType::Commit
      `git commit`
    when StatusEventType::Amend
      `git commit --amend`
    when StatusEventType::DiffView
      file.puts_diff
    when StatusEventType::Checkout
      file.checkout
    else
      file.open_in_editor
    end

    file_index = T.must(all_files.find_index(file))

    file_to_puts = all_files[file_index + 1] || all_files[file_index - 1]

    Status.new.puts_status(file_to_puts)
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