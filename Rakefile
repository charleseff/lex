# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

# for cruisecontrol::
desc "Task to do some preparations for CruiseControl"
task :prepare do
  RAILS_ENV = 'test'
end
desc "Task for CruiseControl.rb"
task :cruise => [:prepare, "db:migrate", "spec", "test"] do
end
# end for cruisecontrol
