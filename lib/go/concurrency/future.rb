module Go
  module CC
    class Future

      def initialize proc
        @mutex = Mutex.new
        @cv = ConditionVariable.new
        @complete = false
        @work = proc
      end

      def work; @work end

      def put val
        @val = val
        put_complete
      end

      def ex e
        @ex = e
        put_complete
      end

      def put_complete
        @complete = true
        @cv.broadcast
      end

      def complete?
        @complete
      end

      def errored?
        !@ex.nil?
      end

      def get
        unless @complete
          @mutex.synchronize do
          unless @complete
            @cv.wait(@mutex)
          end
        end
        end
        if @ex
          raise @ex
        end

        @val
      end

      def wait
        unless @complete
          @mutex.synchronize do
            unless @complete
              @cv.wait(@mutex)
            end
          end
        end
      end

    end
  end
end
