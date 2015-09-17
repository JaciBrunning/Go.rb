# The Kernel Module for GoRuby that is responsible for 'keywords' that can be
# used when 'require "go"' is present
#
# Author::  Jaci Brunning
module ::Kernel

  def go(*channels, &block)
    Thread.new *channels, &block
  end

  def gofork(*pipes, &block)
    Go::Process.new *pipes, &block
  end

  def gopipe
    Go::Pipe.new
  end

  def gochan
    Go::Channel.new
  end

end
