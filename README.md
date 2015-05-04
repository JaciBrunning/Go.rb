# Go.rb
The features of the 'Go' language without the weird syntax.
[![Gem Version](https://badge.fury.io/rb/Go.rb.svg)](http://badge.fury.io/rb/Go.rb)
## Why?
Go is a language that specializes in Concurrency and Control Flow, but many people (myself included), don't like the choice of syntax and language features. Some people may also want these features available in a more common language, such as Ruby, which is why I created Go.rb, a Ruby Gem that brings the best features of 'Go' to Ruby.  

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

# => Hello World
# => Goodbye World
```
In the above case, both "Hello World" and "Goodbye World" are executed in their own, individual threads.
```ruby
require 'go'

go do
  sleep 1
  puts "Hello World"
end
go {puts "Goodbye World"}

# => Goodbye World
# => Hello World
```
Additionally, we also support 'Futures', a way to get the return value of a goroutine, or an Exception if one occurred. This also serves as a way of waiting for a goroutine to execute.  
```ruby
require 'go'

future = go do
  puts "Hello World"
  sleep 3
  5 * 2
end

puts future.get

# => Hello World
# *3 seconds later*
# => 10
```
```future.get``` and ```future.wait``` will both block the current thread until the goroutine has completed executing. ```wait``` will yield nil and ```get``` will yield the result (return) of the goroutine, or raise an exception if there was an error during execution.

## Future Plans
- Defer
- Panic
- Resolve (might not be possible)
