module Go
  class Channel

    def initialize
      @reader, @writer = IO.pipe
    end

    def puts data
      @writer.puts data
    end

    def << data
      write data
    end

    def gets
      @reader.gets
    end

    def write data
      @writer.write data
    end

    def read length=-1
      if length == -1
        @reader.read
      else
        @reader.read length
      end
    end

    def reader
      @reader
    end

    def writer
      @writer
    end

    def close
      destroy
    end

    def destroy
      @reader.close
      @writer.close
      @reader = nil
      @writer = nil
    end
  end
end
