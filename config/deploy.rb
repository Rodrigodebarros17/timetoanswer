# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "timetoanswer"
set :repo_url, "git@github.com:Rodrigodebarros17/timetoanswer.git"
set :ssh_options, { :forward_agent => true }
set :branch, 'main'

# Default branch is :main
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/timetoanswer"

# Default value for :format is :airbrussh.
set :format, :airbrussh

# Log level
set :log_level, :debug

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "storage", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
task :restart do
invoke 'unicorn:stop'
invoke 'unicorn:start'
end
end
