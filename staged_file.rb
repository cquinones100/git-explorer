# typed: strict

require_relative './git_file'

class StagedFile < GitFile
  sig { void }
  def unstage
    `git reset #{file_path}`
  end

  sig { void }
  def puts_diff
    Diff.new(file_path, type: "staged").puts_diff
  end

  sig { void }
  def checkout
    `git reset HEAD #{file_path}`
    `git checkout -- #{file_path}`
  end
end
