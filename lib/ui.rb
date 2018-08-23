class UI
	def receive(input = $stdin)
		input.gets.chomp
	end

	def give(message, output = $stdout)
		output.puts(message)
	end
end