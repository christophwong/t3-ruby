require 'rake/testtask'
require_relative 'lib/game_runner'

Rake::TestTask.new do |t|
  t.pattern = "test/test_*.rb"
end

desc "start a new game of Tic Tac Toe"
task :start do
  GameRunner.run
end
