require 'rake/testtask'
require_relative 'lib/start'

Rake::TestTask.new do |t|
  t.pattern = "test/test_*.rb"
end

desc "start a new game of Tic Tac Toe"
task :start do
  Start.run
end
