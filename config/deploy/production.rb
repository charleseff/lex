set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :domain, "lexkimbookreports.com"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :rails_env, "production"

set :start_port, 8000
set :instances, 3