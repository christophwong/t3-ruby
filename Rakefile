require 'rake/testtask'
require_relative './lib/game_runner.rb'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

desc "starts a new game of Tic Tac Toe"
task :start do
  GameRunner.new.start
end

task :t => :test
task :s => :start
