$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )
require 'go'

future1 = go { sleep 1; puts "Hello World1"; "Done" }
future2 = go { puts "Hello World2"; "Solu" }
puts future1.get
puts future2.get

yourself = gochan

gofork yourself do |chan|
  chan.puts "Test String pls Ignore"
end

puts "#{yourself.gets}"
