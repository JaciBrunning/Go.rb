# Go.rb
A lightweight Ruby concurrency system with multi-thread and multi-process support with Pipes and Channels.
[![Build Status](https://travis-ci.org/JacisNonsense/Go.rb.svg?branch=master)](https://travis-ci.org/JacisNonsense/Go.rb)  [![Gem Version](https://badge.fury.io/rb/Go.rb.svg)](http://badge.fury.io/rb/Go.rb)  [![Coverage Status](https://coveralls.io/repos/JacisNonsense/Go.rb/badge.svg)](https://coveralls.io/r/JacisNonsense/Go.rb) [![Code Climate](https://codeclimate.com/github/JacisNonsense/Go.rb/badges/gpa.svg)](https://codeclimate.com/github/JacisNonsense/Go.rb)
## Why?
Go.rb is inspired by the 'Go' programming language. 'Go' excels in concurrency, so I decided to recreate some of these
features in Ruby. This includes easy creation and management of Threads and Process-Forking. Channels allow communication
across Threads and Pipes allow for data interchange across Processes.

## Getting Started
Getting started with Go.rb is very simple. First, install the Gem:
```
  gem install Go.rb
```
or, in your gem file:  
```ruby
  gem 'Go.rb'
```

Using the gem is very simple. Here are a few examples:  
```ruby
require 'go'

go { puts "Hello World" }
go { puts "Goodbye World" }

# => "Hello World"
# => "Goodbye World"
```
In the above case, both "Hello World" and "Goodbye World" are executed in their own, individual threads.
```ruby
require 'go'

go do
  sleep 1
  puts "Hello World"
end
go { puts "Goodbye World" }

# => "Goodbye World"
# => "Hello World"
```
Additionally, Multiple Processes are supported.
```ruby
require 'go'

gofork { puts "Hello from another Process" }
gofork { sleep 1 }.wait

# => "Hello from another Process"
# => *waits 1 second before exiting*
```

For communication across Threads, a Channels system is implemented. Channels can hold any object
```ruby
require 'go'

channel = gochan    # Create a new Channel
go(channel) { |chan| chan << "Hello World" }
puts channel.get

# => "Hello World"

channel << "Hi Earth"
channel2 = gochan
go(channel, channel2) { |chan, chan2| chan2 << chan.get }
puts channel2.get

# => "Hi Earth"
```

For communication across Processes, a Pipes system is implemented. Objects can not be transferred
across processes, only byte streams like binary strings.
```ruby
require 'go'

pipe = gopipe
gofork(pipe) { |pipe| pipe << "Hello" }
puts pipe.read(5)

# => "Hello"

pipe.puts "Hello World"
gofork(pipe) { |pipe| puts pipe.gets }

# => "Hello World"
pipe.close
```
