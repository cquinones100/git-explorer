# typed: strict

class Git::Base
  sig { returns(T::Array[Git::Object::Commit]) }
  def log
  end

  sig { returns(Git::Status) }
  def status
  end
end

class Git::Author
  sig { returns(String) }
  def name
  end
end

class Git::Object::Commit < Git::Object::AbstractObject
  sig { returns(String) }
  def to_s; end

  sig { returns(Git::Author) }
  def author; end

  sig { returns(String) }
  def author_date; end

  sig { returns(String) }
  def committer; end

  sig { returns(String) }
  def committer_date; end

  sig { returns(String) }
  def date; end

  sig { returns(String) }
  def diff_parent; end

  sig { returns(String) }
  def gtree; end
  def initialize(base, sha, init = nil); end

  sig { returns(String) }
  def message; end

  sig { returns(String) }
  def name; end

  sig { returns(String) }
  def parent; end

  sig { returns(String) }
  def parents; end
end

class Git::Status
  sig { returns(T::Array[String]) }
  def changed; end

  sig { params(file: String).returns(T::Boolean) }
  def changed?(file); end
end