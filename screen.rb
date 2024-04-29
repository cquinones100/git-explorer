# typed: strict

require_relative './action'
require_relative './key'

class Screen
  Buffer = T.type_alias { String }

  sig { returns(Buffer) }
  attr_reader :buffer

  sig { returns(Integer) }
  attr_reader :cursor_position

  sig { void }
  def initialize
    @buffer = T.let("", Buffer)
    @cursor_position = T.let(0, Integer)
    @ticks = T.let([], T::Array[T.proc.params(input: String).void])
  end

  sig { void }
  def start
    print "#{Action::HIDE_CURSOR.serialize}#{Action::CLEAR.serialize}"
    print_buffer

    loop do
      input = T.unsafe(STDIN).getch

      if input == Key::CTRL_C.serialize
        print Action::SHOW_CURSOR.serialize

        exit
      else
        ticks.each do |tick|
          tick.call(input)
        end
      end
    end
  end

  sig { params(block: T.proc.params(input: String).void).void }
  def on_tick(&block)
    @ticks << block
  end

  sig { params(value: Buffer).void }
  def buffer=(value)
    clear

    @buffer = value

    print_buffer
  end

  sig { void }
  def reset
    print Action::SHOW_CURSOR.serialize
  end

  sig { params(value: Integer).void }
  def cursor_position=(value)
    clear

    @cursor_position = value

    print_buffer
  end

  private

  sig {  returns(T::Array[T.proc.params(input: String).void])}
  attr_reader :ticks

  sig { void }
  def print_buffer
    buffer.chars.each_with_index do |char, index|
      if cursor_position == index
        print_cursor(char) 
      else
        print char
      end
    end
  end

  sig { void }
  def clear
    print Action::CLEAR.serialize
  end

  sig { void }
  def clear_cursor
    print Action::HIDE_CURSOR.serialize
  end

  sig { params(char: String).void }
  def print_cursor(char)
    print "\e[47m#{char}\e[0m"
  end
end
