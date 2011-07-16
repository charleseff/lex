set :deploy_to, "/home/deploy/public_html/lexkimbookreports.cmanfu.com"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :domain, "cmanfu.com"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :rails_env, "staging"

set :start_port, 8001
set :instances, 1