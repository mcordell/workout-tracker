root = "/home/michael/apps/workout_tracker/current"

working_directory root

stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.workout_tracker.sock"
worker_processes 1
timeout 30

rails_env = ENV['RAILS_ENV'] || 'production'

pid "#{root}/tmp/pids/unicorn.pid"

