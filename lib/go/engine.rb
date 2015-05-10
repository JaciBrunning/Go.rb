module Go
  class Engine

    def initialize(max_size=10, growing=true)
      @config = Go::Config.new(max_size, growing)
    end

    def go &block
      @config.thread_pool.execute_proc block
    end

    def config
      @config
    end

  end
end
