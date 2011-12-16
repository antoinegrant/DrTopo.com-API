set :user, 'agrant1'  # Your dreamhost account's username
set :domain, 'api.drtopo.co'  # Dreamhost servername where your account is located 
set :project, 'DrTopo.com-API'  # Your application as its called in the repository
set :application, 'api.drtopo.co'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

# version control config
set :scm_username, 'antoinegrant'
set :scm_password, '247climbing'
set :scm, 'git'
set :repository,  "git@github.com:antoinegrant/DrTopo.com-API.git"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

ssh_options[:forward_agent] = true

# roles (servers)
role :web, domain
role :app, domain
# role :db,  db_host, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
ssh_options[:keys] = %w(~/.ssh/id_rsa)            # If you are using ssh_keys
# set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "ls -al"
    run "cd #{current_release} && bundle install"
    run "cd #{current_release} && rake db:migrate RACK_ENV=production"
    run "touch #{current_release}/tmp/restart.txt"
  end
end