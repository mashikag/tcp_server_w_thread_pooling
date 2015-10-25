require 'socket'
require 'thread'
kill = false

unless ARGV.length == 1
  print "The correct number of arguments is 1!\n"
  exit
end

port = ARGV[0]
puts "Servers started on port #{port}"

server = TCPServer.new port
clients_q = Queue.new

Thread.new do
  loop do
    Thread.start(server.accept) do |client|
      puts "client connected"
      clients_q.push(client)
    end
  end
end

workers = (0...2).map do
  Thread.new do
    begin
      while client = clients_q.pop()
        input = client.gets
        if input == "hello\n"
          client.puts "Hello\n"
        elsif input == "kill\n"
          client.puts "Kill\n"
          kill = true
        else
          client.puts "wot"
        end
        client.close
      end
    end
  end
end

while !kill
end
