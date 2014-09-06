set :application, 'workout_tracker'
set :repo_url, 'git@git.mdcordell.com:mcordell/workout_tracker.git'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '1.9.3-p448'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/home/michael/apps/workout_tracker"
set :scm, :git
set :format, :pretty
#set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  task :setup_config do
    on roles(:app), except: {no_release: true} do
      execute 'sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/workout"'
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

end
