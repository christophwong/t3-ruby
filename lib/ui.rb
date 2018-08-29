class UI
  def give(message, io)
    io.puts message
  end

  def receive(io)
    io.gets
  end
end
