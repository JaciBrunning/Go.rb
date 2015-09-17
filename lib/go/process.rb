module Go
  class Process

    def initialize *pipes, &block
      @pid = fork { block.call *pipes }
    end

    def wait
      ::Process.wait pid
    end

    def pid
      @pid
    end

    def kill
      ::Process.kill 9, pid
    end

  end
end
