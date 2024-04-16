# typed: strict

require "rubygems"
require "bundler/setup"
require 'cli/ui'
require 'open3'
require 'git'

extend T::Sig

command = ARGV[0]
path = ARGV[1]

git = Git.open(path)

class Log
  extend T::Sig
  
  sig { params(git: Git::Base).void }
  def initialize(git)
    @git = T.let(git, Git::Base)
  end
  
  sig { void }
  def puts_log
    CLI::UI::Frame.open('Git Log') do
      CLI::UI::Prompt.ask('') do |handler|
        @git.log.each do |commit|
          handler.option("#{commit.to_s} - #{commit.author.name} - #{commit.date}") do
            system("echo #{commit} | pbcopy")

            "Copied to clipboard: #{commit}"
          end
        end
      end
    end
  end
end

case command
when 'log'
  Log.new(git).puts_log
end

CLI::UI::StdoutRouter.enable