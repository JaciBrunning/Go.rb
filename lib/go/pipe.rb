module Go
  class Pipe

    def initialize
      @reader, @writer = IO.pipe
    end

    def puts data=""
      writer.puts data
    end

    def << data
      write data
    end

    def gets
      reader.gets
    end

    def write data
      writer.write data
    end

    def read length
      reader.read length
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
      reader.close
      writer.close
      @reader = nil
      @writer = nil
    end
  end
end
