# typed: strict

require 'sorbet-runtime'
require 'tty-prompt'

require_relative './status'

class Hunk
  extend T::Sig

  sig do
    params(changes: T::Array[String], header: T::Array[String])
      .void
  end
  def initialize(changes, header)
    @changes = T.let(changes, T::Array[String])
    @patch_line = T.let(T.must(changes.first), String)
    @first_line = T.let(T.must(changes.first).gsub(/@@.*@@/, ""), String)
    @rest_lines = T.let(T.must(changes[1..-1]), T::Array[String])
    @header = T.let(header, T::Array[String])
  end

  sig { returns(String) }
  def to_s
    ([@first_line] + @rest_lines.map { |line| "  #{line}" }).join("\n")
  end

  sig { returns(String) }
  def to_patch
    (@header + [@patch_line] + @rest_lines).join("\n") + "\n"
  end
end

class DiffEvent < T::Enum
  enums do
    Back = new
    Checkout = new
    Add = new
  end
end

class Diff
  extend T::Sig

  sig { returns(String) }
  attr_reader :path

  sig { params(path: String, type: T.nilable(String)).void }
  def initialize(path, type: nil)
    @path = path
    @type = type
  end

  sig { void }
  def puts_diff
    prompt = T.let(TTY::Prompt.new(symbols: { cross: '' }), TTY::Prompt)
    event_type = T.let(nil, T.nilable(DiffEvent))

    prompt.on(:keypress) do |event|
      if event.value == "j"
        prompt.trigger(:keydown)

      end
    
      if event.value == "k"
        prompt.trigger(:keyup)
      end

      if event.value == "a"
        event_type = DiffEvent::Add
        prompt.trigger(:keyenter)
      end

      if event.value == "x"
        event_type = DiffEvent::Checkout
        prompt.trigger(:keyenter)
      end

      if event.value == "\u000F"
        event_type = DiffEvent::Back
        prompt.trigger(:keyenter)

      end
    end

    selected_change = prompt.select("Select a change", per_page: 100) do |menu|
      menu.help <<-HELP

j/k: scroll up/down
a: add
u: unstage
ctrl+o: back
      HELP

      changes.each_with_index do |change, index|
        menu.choice(change.to_s, index)
      end
    end

    return unless selected_change.is_a?(Integer)
    return unless event_type

    if event_type
      case event_type
      when DiffEvent::Add
        patch_to_apply = T.must(changes[selected_change]).to_patch
  
        File.write("patch.patch", patch_to_apply)
  
        system("git apply --cached -v patch.patch")
  
        `rm patch.patch`
      when DiffEvent::Back
        Status.new.puts_status
      end
    end
  end

  private

  sig { returns(String) }
  def diff
    case @type
    when "unstaged"
      `git diff #{path}`
    when "staged"
      `git diff --staged #{path}`
    else
      raise "Unkown diff type, expected 'staged|unstaged'"
    end
  end

  sig { returns(T::Array[String]) }
  def diff_lines
    diff_lines = diff.split("\n")

    longest_line = T.must(diff_lines.max_by(&:length)).length

    diff_lines.map do |line|
      line
    end
  end

  sig { returns(T::Array[String]) }
  def header
    header = []

    diff_lines.each do |line|
      if line.start_with?("diff") ||
        line.start_with?("index") ||
        line.start_with?("---") ||
        line.start_with?("+++")
        header << line

        next
      end
    end

    header
  end

  sig { returns T::Array[Hunk] }
  def changes
    changes = []
    current_change = []

    diff_lines.each do |line|
      if line.start_with?("diff") ||
        line.start_with?("index") ||
        line.start_with?("---") ||
        line.start_with?("+++")
        next
      end

      if line.start_with?("@@")
        changes << current_change unless current_change.empty?

        current_change = []
      end

      current_change << line
    end

    changes << current_change if current_change.any?

    changes.map { |change| Hunk.new(change, header)}



  end
end
