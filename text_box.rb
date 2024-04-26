# typed: strict

require_relative './spacer'

class TextBox < HelpText
  sig { returns(String) }
  attr_reader :text

  sig { returns(HelpText) }
  attr_reader :container

  sig { params(text: String, container: HelpText).void }
  def initialize(text, container:)
    super(width: nil, height: nil)

    @text = text
    @container = container
    @container.all_sections << self
  end

  sig { void }
  def puts_frame
    container.rendered_items << Spacer.new

    self.top = container.rendered_items.sum(&:height)
    self.left = container.padding
    self.height = text.split("\n").size
    self.padding = 0
    self.border = HelpText::BorderType::None

    super

    container.rendered_items << self
  end
end
