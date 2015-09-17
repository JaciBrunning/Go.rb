$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )
require 'coveralls'
Coveralls.wear!
require 'test/unit'
require 'go'

class GoUnit < Test::Unit::TestCase

  def test_threads
    puts "Testing Basic Channels"
    c = gochan
    go(c) { |c| sleep 0.5; c<< 2 }
    go(c) { |c| c << 0 }
    go(c) { |c| sleep 1; c << 3 }
    go(c) { |c| sleep 0.25; c << 1 }

    4.times do |i|
      get = c.get
      assert_equal(i, get)
    end
  end

  def test_channels
    puts "Testing Advanced Channels"
    c1, c2, c3, c4 = 4.times.map { gochan }
    go(c1, c2) { |c1, c2| c1 << "Hi"; assert_equal(c2.pop, "Hello") }
    go(c3, c2) { |c3, c2| c3 << "Hey"; c2 << "Hello" }
    go(c1, c3, c4) { |c1, c3, c4| assert_equal(c1.pop, "Hi"); c4 << c3.pop  }
    assert_equal(c4.pop, "Hey")
  end

  def test_processes
    puts "Testing Processes"
    pipe = gopipe
    gofork(pipe) { |pi| pi.puts "Hello World" }
    assert_equal(pipe.gets.chop!, "Hello World")
    pipe.close
  end

  def test_kill_wait
    puts "Testing Kills and Waits"
    pipe = gopipe
    gofork(pipe) { sleep 1; pipe.puts "Yes" }.wait
    gofork(pipe) { sleep 1; pipe.puts "No" }.kill
    assert_equal(pipe.gets.chop!, "Yes")
    pipe.close
  end

  def test_pipes
    puts "Test Pipes"
    pipe = gopipe
    gofork(pipe) do |pi|
      pi << "Test"
    end
    assert_equal(pipe.read(4), "Test")
  end

  def test_pipe_single
    puts "Test Pipes Single Process"
    pipe = gopipe
    pipe.puts "Test"
    pipe << "Other"
    assert_equal(pipe.gets.chop!, "Test")
    assert_equal(pipe.read(5), "Other")
  end

end
