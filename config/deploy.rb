# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'hepte'
set :repo_url, 'git@github.com:yasinn/hepte.git'
set :deploy_to, -> { "/srv/www/#{fetch(:application)}" }
set :rails_env, 'production'

set :linked_files, %w{config/database.yml config/config.yml config/secret.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

namespace :deploy do
  desc "Restart unicorn and resque"
  task :restart do
    invoke 'deploy:passenger:restart'
    invoke 'deploy:resque:restart'
  end
  after :publishing, :restart

  namespace :passenger do
    task :restart do
      on roles(:app) do
        execute :touch, "#{release_path}/tmp/restart.txt"
      end
    end
  end

  namespace :resque do
    %w( start stop restart ).each do |action|
      desc "#{action} resque worker"
      task action do
        on roles(:app) do
          execute :service, :resque, action
        end
      end
    end
  end
end