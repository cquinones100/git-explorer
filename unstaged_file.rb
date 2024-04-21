# typed: strict

require_relative './git_file'

class UnstagedFile < GitFile
  sig { void }
  def add
    `git add #{file_path}`
  end

  sig { void }
  def puts_diff
    Diff.new(file_path, type: "unstaged").puts_diff
  end
end