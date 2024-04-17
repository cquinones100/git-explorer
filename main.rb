# typed: strict

require "rubygems"
require "bundler/setup"
require 'sorbet-runtime'
require 'open3'
require 'tty-prompt'
require_relative './log'

extend T::Sig

command = ARGV[0]

class CommandHandler
  extend T::Sig

  sig { params(git: Git::Base).void }
  def initialize(git)
    @git = T.let(git, Git::Base)
  end

  sig do
    params(
      title: String,
      options_proc: T.proc.params(handler: ::CLI::UI::Prompt::OptionsHandler).void
    ).returns(T.nilable(T.any(T::Array[String], String))
  )
  end
  def show(title, &options_proc)
    CLI::UI::Frame.open(title) do
      CLI::UI::Prompt.ask('') do |handler|
        yield(handler)
      end
    end
  end
end

class Status
  extend T::Sig

  sig { void }
  def puts_status
    system('clear')

    prompt = T.let(TTY::Prompt.new(symbols: { cross: '' }), TTY::Prompt)

    action = T.let(nil, T.nilable(String))

    prompt.on(:keypress) do |event|
      if event.value == "j"
        prompt.trigger(:keydown)
      end
    
      if event.value == "k"
        prompt.trigger(:keyup)
      end

      if event.value == "a"
        if action == "c"
          action = "ca"
        else
          action = "add"
        end

        prompt.trigger(:keyenter)
      end

      if event.value == "A"
        action = "add all"

        prompt.trigger(:keyenter)
      end

      if event.value == "u"
        action = "unstage"

        prompt.trigger(:keyenter)
      end

      if event.value == "c"
        if action == "c"
          action = "cc"
          prompt.trigger(:keyenter)
        else
          action = "c"
        end
      end

      if event.value == "d"
        action = "d"
      end

      if event.value == "v"
        if action == "d"
          action = "dv"

          prompt.trigger(:keyenter)
        end
      end
    end

    all_files = added + unstaged_files + untracked_files

    puts "nothing to commit, working tree clean" if all_files.empty?

    return if all_files.empty?

    path = prompt.select(
      "Status", 
      per_page: all_files.size + 3
    ) do |menu|
      menu.help "(Use j/k to move, space to select and enter to finish)"
      if added.any?
        menu.choice "Added", 2, disabled: ''
        added.each do |path|
          menu.choice path, "#{path}"
        end
      end

      if unstaged_files.any?
        menu.choice "Changes not staged for commit:", 2, disabled: ''
        unstaged_files.each do |path|
          menu.choice path, "#{path}"
        end
      end

      if untracked_files.any?
        menu.choice "Untracked files:", 3, disabled: ''
        untracked_files.each do |path|
          menu.choice path, "#{path}"
        end
      end
    end

    case action
    when "unstage"
      unstage(path) if path
    when "add"
      add(path) if path
    when "add all"
      add(".")
    when "cc"
      `git commit`
    when "ca"
      `git commit --amend`
    when "dv"
      `git difftool -y -x 'code --wait --diff'` 
    else
      system("code -g #{path}")
    end

    puts_status
  end

  private

  sig { returns(T::Array[String]) }
  def added
    output = `git diff --name-only --cached`
    output.split("\n").map(&:strip)
  end

  sig { returns(T::Array[String]) }
  def unstaged_files
    output = `git diff --name-only`
    output.split("\n").map(&:strip)
  end

  sig { returns(T::Array[String]) }
  def untracked_files
    `git ls-files --others --exclude-standard`.split("\n").map(&:strip)
  end

  sig { params(path: String).void }
  def add(path)
    `git add #{path}`
  end

  sig { params(path: String).void }
  def unstage(path)
    `git reset #{path}`
  end
end

begin
case command
when 'log'
  Log.new.puts_log
when 'status'
  Status.new.puts_status
  end
rescue TTY::Reader::InputInterrupt
end
