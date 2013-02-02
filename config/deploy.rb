require "bundler/capistrano"

set :application, "Clifton Studios"
set :repository,  "git://github.com/kmcphillips/cliftonstudios.ca.git"
set :deploy_to, "/var/www/kevin/data/www/cliftonstudios.ca"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 5

#set :rake, "bundle exec rake"

default_run_options[:pty] = true

role :web, "68.169.58.121"
role :app, "68.169.58.121"
role :db,  "68.169.58.121", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update", "deploy:cleanup"

## Callbacks
after "deploy", "symlink_shared_files" ##, "generate_sitemaps" # This was nothing but a hassle. do it manually

task :symlink_shared_files do
  run "ln -s #{shared_path}/assets #{release_path}/public/assets"

  %w{database.yml mail.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end

task :generate_sitemaps do
  run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake sitemap:refresh"
end

