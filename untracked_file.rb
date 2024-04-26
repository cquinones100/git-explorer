# typed: strict

require_relative './git_file'

class UntrackedFile < UnstagedFile
  sig { void }
  def puts_diff
    Diff.new(file_path, type: "untracked").puts_diff
  end
end