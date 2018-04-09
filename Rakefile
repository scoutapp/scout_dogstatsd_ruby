require "bundler/gem_tasks"

task :test do
  $: << File.expand_path(File.dirname(__FILE__) + "/test")
  Dir.glob('./test/*_test.rb').each { |file| require file }
end

desc "Run tests"
task :default => :test

