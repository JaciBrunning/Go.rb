# The Kernel Module for GoRuby that is responsible for 'keywords' that can be
# used when 'require "go"' is present
#
# Author::  Jaci Brunning
module ::Kernel

  def go(&block)
    Go::Config.get().thread_pool().execute_proc(block)
  end

end
