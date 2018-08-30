class UI
  def give(message, io = $stdout)
    io.puts message
  end

  def receive(io = $stdin)
    io.gets
  end
end
