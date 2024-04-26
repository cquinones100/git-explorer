# typed: strict

require_relative './spacer'
require 'tty-box'
require 'tty-screen'

class HelpText
  class BorderType < T::Enum
    enums do
      Top = new
      None = new
      On = new
    end
  end

  BorderShape = T.type_alias do
    T::Hash[Symbol, T.any(Symbol, FalseClass)]
  end

  sig { returns(String) }
  attr_reader :text

  sig { returns(T.nilable(String)) }
  attr_reader :title

  sig { returns(Integer) }
  attr_reader :height

  sig { returns(Integer) }
  attr_reader :width

  sig { returns(Integer) }
  attr_reader :padding

  sig { params(padding: Integer).void }
  attr_writer :padding

  sig { params(top: Integer).returns(Integer) }
  attr_writer :top
  sig { returns(Integer) }
  attr_reader :top

  sig { params(left: Integer).returns(Integer) }
  attr_writer :left
  sig { returns(Integer) }
  attr_reader :left

  sig { returns(T.nilable(BorderShape)) }
  attr_reader :border

  sig { returns(T::Array[HelpText])}
  attr_reader :all_sections

  sig { returns(T::Array[T.any(Spacer, HelpText)])}
  attr_reader :rendered_items

  sig { params(title: T.nilable(String), width: T.nilable(Integer), height: T.nilable(Integer)).void }
  def initialize(title = nil, width: nil, height: nil)
    @title = T.let(title, T.nilable(String))
    @text = T.let("", String)
    @width = T.let(width || TTY::Screen.width, Integer)
    @height = T.let(0, Integer)
    @padding = T.let(1, Integer)
    @top = T.let(0, Integer)
    @left = T.let(0, Integer)
    @border = T.let(nil, T.nilable(BorderShape))
    @all_sections = T.let([], T::Array[HelpText])
    @rendered_items = T.let([Spacer.new], T::Array[T.any(Spacer, HelpText)])
  end

  sig { params(value: Integer).void }
  def margin_width(value)
    @width -= (value * 2)
  end

  sig { void }
  def puts_frame
    puts frame
  end

  sig { params(text: String).void }
  def text=(text)
    @text = text
    text_height = text.split("\n").size

    self.height = text.split("\n").size + 2
  end

  sig { params(next_line: String).void }
  def <<(next_line)
    @text += "\n"
    @text += next_line
    text_height = text.split("\n").size

    self.height = text.split("\n").size + 2
  end

  sig { params(type: BorderType).void }
  def border=(type = BorderType::On)
    @border = case type
    when BorderType::Top
      {
        bottom: false,
        left: false,
        top: true,
        right: false,
        top_left: false,
        top_right: false,
        bottom_left: false,
        bottom_right: false
      }
    when BorderType::None
      {
        bottom: false,
        left: false,
        top: false,
        right: false,
        top_left: false,
        top_right: false,
        bottom_left: false,
        bottom_right: false
      }
      


    end
  end

  sig { params(value: T.any(Float, Integer)).void }
  def height=(value)
    @height = value.to_i
  end

  private

  sig { returns(T.untyped) }
  def frame
    options = {
      align: :left,
      padding:,
      width:,
      height:,
      top:,
      left:
    }

    options[:title] = { top_left: title } if title
    options[:border] = border if border

    TTY::Box.frame(text, **options)
  end
end