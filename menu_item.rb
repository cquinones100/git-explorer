# typed: strict

require 'tty-box'
require 'tty-screen'
require_relative './help_text'

class MenuItem < HelpText
  sig do
    params(
      text: String,
      container: HelpText,
      selected: T::Boolean
    )
      .void
  end
  def initialize(text, container:, selected: false)
    super(width: nil, height: nil)
    @text = text
    @container = container
    @container.all_sections << self
    @selected = selected
  end
  
  sig { void }
  def puts_frame
    self.top = container.rendered_items.sum(&:height)
    self.left = container.padding
    self.padding = 0
    self.border = HelpText::BorderType::None
    self.height = text.split("\n").size
    @text = "- #{text}" if selected

    super

    container.rendered_items << self
  end

  private

  sig { returns(HelpText) }
  attr_reader :container

  sig { returns(T::Boolean) }
  attr_reader :selected
end
