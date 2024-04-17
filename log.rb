# typed: strict

require 'sorbet-runtime'
require 'tty-prompt'

class Commit
  extend T::Sig

  sig { params(lines: T::Array[String]).void }
  def initialize(lines)
    @lines = lines
  end

  sig { returns(String) }
  def sha
    raise 'Issue loading commit' unless lines[0]&.start_with?("commit")

    T.must(T.must(lines[0]).split(" ")[1])
  end

  sig { returns(String) }
  def author
    raise 'Issue loading author' unless lines[1]&.start_with?("Author")

    T.must(T.must(lines[1]).split(": ")[1])
  end

  sig { returns(String) }
  def date
    raise 'Issue loading date' unless lines[2]&.start_with?("Date")

    T.must(T.must(lines[1]).split(": ")[1])
  end

  sig { returns(String) }
  def message
    raise 'Issue loading message' unless lines[4]

    T.must(lines[4..-1]).map(&:strip).join("\n")
  end

  private

  sig { returns(T::Array[String]) }
  attr_reader :lines
end

class Log
  extend T::Sig

  sig { void }
  def puts_log
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
    end

    sha = prompt.select('Log', per_page: [entries.size, 20].min) do |menu|
      menu.help "(Use j/k to move, space to select and enter to rebase to that SHA)"

      entries.each do |entry|
        menu.choice(
          "#{entry.sha} - #{entry.message.split("\n")[0]}",
          entry.sha
        )
      end
    end

    output = `git rebase -i #{sha}~1`
  end

  private

  sig { returns(T::Array[Commit]) }
  def entries
    @entries ||= T.let([], T.nilable(T::Array[Commit]))

    return @entries if @entries.any?

    @entries = begin
      entries = []

      T.let([], T::Array[Commit])
      current_entry = T.let([], T::Array[String])

      output.split("\n").each do |line|
        if line.start_with?("commit") && !current_entry.empty?
          entries << Commit.new(current_entry)
          current_entry = []
        end

        current_entry << line
      end

      entries
    end
  end

  sig { returns(String) }
  def output
    @output ||= T.let(`git log`, T.nilable(String))
  end
end