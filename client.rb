require 'socket'

loop do # Read lines from socket  
  s = TCPSocket.new 'localhost', 2005
  puts "waiting for user input"
  puts "sending user input"
  s.puts(gets)         # and print them
  puts "sent user input"
  puts s.gets
  s.close
end

s.close             # close socket when done
