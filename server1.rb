require 'socket'
require 'thread'

unless ARGV.length == 1
  print "The correct number of arguments is 1!\n"
  exit
end

port = ARGV[0]
puts "Servers started on port #{port}"

server = TCPServer.new port
activeQ = Queue.new

threadNum = 0


Thread.new do
  loop do
    Thread.start(server.accept) do |client|
      activeQ.push(client)
    end
  end  
end

Thread.new do
  while true
    if !activeQ.empty? and threadNum < 3
      Thread.new do
        puts"#{threadNum}"
        threadNum+=1
        client = activeQ.pop()
        puts "Client active"
        client.puts "'#{Time.now} + #{threadNum}"
        clientRunning = true
        while clientRunning
          input = client.gets       
          if input == "HELO\n"
            client.puts "Hello"
          elsif input == "KIL\n"
            client.puts "KILL"
            puts "SERVER KILLED"
            exit    
          end
        end
        client.puts("Disconnected")
        threadNum -=1
        client.close
      end
    end
  end 
end

while true

end
