module Go
  class Process

    def initialize *channels, &block
      @channels = channels
      @pid = fork {
        block.call *channels
      }
    end

    def wait
      ::Process.wait @pid
    end

    def channels
      @channels
    end

    def pid
      @pid
    end

    def kill
      ::Process.kill 9, @pid
    end

  end
end
