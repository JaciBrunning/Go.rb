require 'thread'
require 'go/concurrency/future'
module Go
  module CC
    class ThreadPool

      def initialize(max_size = 10, growing = true)
        @max = max_size
        @threadCount = 0
        @threads = []
        @growing = growing
        @workQueue = Queue.new
        @running = true

        initStatic() unless @growing
      end

      def initStatic
        @max.times do
          pushThread
        end
      end

      def pushThread
        @threads << Thread.new do
          while @running
            future = @workQueue.pop
            begin
              future.put future.work().call()
            rescue Exception => e
              future.ex e
            end
          end
        end
        @threadCount+=1
      end

      def execute(&block)
        return execute_proc(block)
      end

      def execute_proc(proc)
        future = Future.new proc
        @workQueue << future

        if @threadCount < @max && @growing
          createNew = false
          @threads.each do |t|
            if t.status() != "sleep"
              createNew = true
            end
          end
          if (@threadCount == 0)
            createNew = true
          end
          pushThread() if createNew
        end

        return future
      end

      def shutdown
        @running = false
      end

      def max; @max end
      def growing?; @growing end
      def running?; @running end
      def workers; @threadCount end
      def queued; @workQueue.size() end

      def status
        status = "Thread Pool: \n"
        status << "\tMax Size: #{max}, Worker Count: #{workers}\n"
        status << "\tGrowing?: #{growing? ? 'true' : 'false'}, Queued Jobs: #{queued}\n"
        status << "\tRunning?: #{running? ? 'true' : 'false'}\n"
        return status
      end

    end
  end
end
