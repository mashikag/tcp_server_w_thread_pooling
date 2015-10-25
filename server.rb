require 'socket'
require 'thread'

STUDENT_ID = "8803c9fec95b618e5d62ff10fd761e1439475ce130adeb57addf0797af531b73"
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
        if (/HELO \w/).match(input) != nil
          client.puts "#{input}\nIP:[ip address]\nPort:[#{port}]\nStudentID:{#{STUDENT_ID}}\n"
        elsif input == "KILL SERVICE\n"
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
