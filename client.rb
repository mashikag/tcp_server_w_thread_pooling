require 'socket'

loop do # Read lines from socket  
  puts "waiting for user input"
  user_input = gets.chomp  
  puts "sending user input"
  s = TCPSocket.new 'localhost', 2005
  s.puts(user_input)         # and print them
  puts "sent user input"
  puts s.gets
  s.close
end

s.close             # close socket when done
