$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )
require 'go'
require 'test/unit'

class GoUnit < Test::Unit::TestCase

  def test_threadpool
    puts "Running Threadpool Tests"
    Go::Config.create(5)

    assert_equal(Go::Config.get.thread_pool.max, 5)
    puts Go::Config.get.thread_pool.status
    puts "Threadpool Tests Complete"
  end

  def test_routines
    puts "Running Routines Tests"
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
end
