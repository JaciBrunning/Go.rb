$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )
require 'coveralls'
Coveralls.wear!
require 'test/unit'
require 'go'

class GoUnit < Test::Unit::TestCase

  def test_threadpool_growing
    puts "Running Threadpool Growth Tests"
    Go::Config.create(5)

    assert_equal(Go::Config.get.thread_pool.max, 5)
    assert_equal(Go::Config.get.max_thread_count, 5)
    assert_equal(Go::Config.get.thread_pool.workers, 0)

    fut1 = go { puts "Testing 1 Routine" }
    fut2 = go { puts "Testing 2 Routines" }

    assert_equal(Go::Config.get.thread_pool.workers, 2)

    10.times do
      go { sleep 1 }
    end

    fut1.wait
    fut2.wait

    puts Go::Config.get.thread_pool.status
    assert_equal(Go::Config.get.thread_pool.workers, 5)
    Go::Config.get.thread_pool.shutdown
    assert_equal(Go::Config.get.thread_pool.running?, false)
    puts "Threadpool Growth Tests Complete"
  end

  def test_threadpool_static
    puts "Running Threadpool Static Size Tests"
    Go::Config.create(5, false)
    assert_equal(Go::Config.get.thread_pool.max, 5)
    assert_equal(Go::Config.get.thread_pool.workers, 5)

    fut1 = go { puts "Testing 1 Routine" }
    fut2 = go { puts "Testing 2 Routines" }

    assert_equal(Go::Config.get.thread_pool.workers, 5)

    10.times do
      go { sleep 1 }
    end

    fut1.wait
    fut2.wait

    assert_equal(Go::Config.get.thread_pool.workers, 5)
    puts Go::Config.get.thread_pool.status
    puts "Threadpool Static Tests Complete"
  end

  def test_routine_exception
    puts "Running Routine Failure Tests"
    futureFailed = go do
      puts "Future Failing"
      raise "New Exception"
    end

    state = false
    futureFailed.wait
    assert_equal(futureFailed.errored?, true)
    begin
      futureFailed.get
      state = false
      puts "Future Exception Test Failed"
    rescue Exception => e
      state = true
      puts "Future Exception Test Successful"
    ensure
      assert_equal(state, true)
      puts "End Routines Failure Test"
    end
  end

  def test_routines
    puts "Running Routines Tests"
    Go::Config.create()
    future1 = go do
      puts "Future 1"
      5 * 2
    end

    future2 = go do
      puts "Future 2"
      8 * 0.5
    end

    assert_equal(future1.get, 10)
    assert_equal(future2.get, 4)
    puts "Routines Tests Complete"
  end

  def test_pool_standalone
    puts "Testing Standalone Pool"
    pool = Go::CC::ThreadPool.new

    future = pool.execute {
      puts "Testing Standalone"
      sleep 1.5
      5 * 2
    }

    assert_equal(future.complete?, false)
    assert_equal(future.get, 10)

    puts "Standalone Pool Test Successful"
  end

  def test_engine
    puts "Testing Engine"
    engine = Go::Engine.new
    engine.go { puts "Hello World" }
    fut2 = engine.go do
      puts "Goodbye World"
    end
    fut2.wait
    engine.config.thread_pool.shutdown
    puts "Finished Testing Engine"
  end

end
