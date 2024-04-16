# typed: strict

require "rubygems"
require "bundler/setup"
require 'cli/ui'
require 'open3'

extend T::Sig

command = ARGV[0]
path = ARGV[1]

git = Git.open(path)

case command
when 'log'
  Log.new(git).puts_log
end

class Log
  extend T::Sig

  sig { params(git: Git::Base).void }
  def initialize(git)
    @git = T.let(git, Git::Base)
  end

  sig { void }
  def puts_log
    puts @git.log
  end
end
