$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )
require 'go'

channel = gochan
go(channel) { |chan| chan << "Hello World" }
go(channel) { |chan| puts chan.get; chan << "How's it going?" }
puts channel.get

puts

pipe = gopipe
gofork(pipe) { |pipe| pipe.puts "Hi from another Process" }
puts pipe.gets
