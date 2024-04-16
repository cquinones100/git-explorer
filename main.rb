# typed: strict

require "rubygems"
require "bundler/setup"
require 'cli/ui'
require 'open3'

extend T::Sig

command = ARGV[0]

case command
when 'log'
  Log.new.puts_log
end

class Log
  sig { void }
  def puts_log
    Git.open
  end
end
