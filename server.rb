require 'socket'

port = ARGV[0]
server = TCPServer.new port

loop do
  client = server.accept
  puts "Client connected"
  client.puts "Hello!"
  client.puts "TIme is #{Time.now}"
  client.close
end
