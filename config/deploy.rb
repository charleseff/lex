set :stages, %w(staging production)
require 'capistrano/ext/multistage'

set :application, "lexkimbookreports"

set :runner, 'deploy'
set :user, 'deploy'

set :application, "lexkimbookreports"
set :repository, "svn+ssh://deploy@cmanfu.com/opt/repos/lexkimbookreports.svn/#{application}/trunk"

set :deploy_via, :remote_cache

# overwrite deploy to allow arguments with the spin script:
namespace :deploy do
  task :start, :roles => :app do
    as = fetch(:runner, "app")
    via = fetch(:run_method, :sudo)
    invoke_command "sh -c 'cd #{current_path} && nohup script/spin #{current_path} #{start_port} #{instances} #{rails_env}'", :via => via, :as => as
  end
end

ssh_options[:paranoid] = false