# typed: strict

require "rubygems"
require "bundler/setup"
require 'sorbet-runtime'
require 'open3'
require 'tty-prompt'
require_relative './log'
require_relative './diff'

extend T::Sig

command = ARGV[0]

class Status
  extend T::Sig

  sig { params(default: T.nilable(String)).void }
  def puts_status(default = nil)
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

      if event.value == "X"
        action = "checkout"

        prompt.trigger(:keyenter)
      end
    end

    all_files = added + unstaged_files + untracked_files

    puts "nothing to commit, working tree clean" if all_files.empty?

    return if all_files.empty?

    path = prompt.select(
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
      menu.default(default) if default

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
      Diff.new(path).puts_diff
    when "checkout"
      `git checkout #{path}`
    else
      system("code -g #{path}")
    end

    path_index = T.must(all_files.find_index(path))

    puts_status(all_files[path_index + 1] || all_files[path_index - 1])
  end

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
when 'diff'
  Diff.new(ARGV[1]).puts_diff
end
rescue TTY::Reader::InputInterrupt
end
