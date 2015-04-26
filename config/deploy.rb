# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'RecipeMe'
set :repo_url, 'git@github.com:mrGhosd/RecipeMe.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/recipeme"
set :deploy_user, 'deploy'

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system .env realtime}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart do

  end


  # after :restart, :clear_cache do
  #   on roles(:app), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

end