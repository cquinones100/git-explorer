# typed: strict

class GitFile
  sig { returns(String) }
  attr_reader :file_path

  sig { params(file_path: String ).void }
  def initialize(file_path:)
    @file_path = file_path
  end

  sig { void }
  def checkout
    `git checkout #{file_path}`
  end

  sig { void }
  def open_in_editor
    system("code -g #{file_path}")
  end
end
