require "bundler/capistrano"
require "rvm/capistrano"
require "whenever/capistrano"

set :application, "Clifton Studios"
set :repository,  "git://github.com/kmcphillips/cliftonstudios.ca.git"
set :deploy_to, "/home/kevin/cliftonstudios.ca"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 5

default_run_options[:pty] = true

role :web, "198.211.110.159"
role :app, "198.211.110.159"
role :db,  "198.211.110.159", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update", "deploy:cleanup"

after "deploy:finalize_update", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/assets #{release_path}/public/attachments"

  %w{database.yml mail.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end

# after "deploy:finalize_update", "generate_sitemaps"
task :generate_sitemaps do
  run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake sitemap:refresh"
end

