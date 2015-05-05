module Go
  class Config

    def initialize(max_threads, growing = true)
      @threads = max_threads
      @pool = Go::CC::ThreadPool.new(max_threads, growing)
    end

    def thread_count
      @threads
    end

    def thread_pool
      @pool
    end

    def self.create(max_threads = 10, growing = true)
      @@config = Config.new(max_threads, growing)
    end

    def self.maybe_create(max_threads = 10)
      @@config ||= Config.new(max_threads)
    end

    def self.get
      maybe_create
      @@config
    end

  end
end
