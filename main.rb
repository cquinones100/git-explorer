# typed: strict

require "rubygems"
require "bundler/setup"
require 'sorbet-runtime'
require 'open3'
require 'tty-prompt'

extend T::Sig

command = ARGV[0]
class Module
  include T::Sig
end

require_relative './status'
require_relative './log'
require_relative './diff'

begin
case command
when 'log'
  Log.new.puts_log
when 'status'
  Status.new.puts_status
when 'diff'
  Diff.new(ARGV[1]).puts_diff
end
rescue TTY::Reader::InputInterrupt
end
