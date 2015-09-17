require "go/version"
require "go/kernel"
require "go/pipe"
require "go/process"

module Go
  class Channel < Queue
    def get nonblock=false
      pop nonblock
    end
  end
end
