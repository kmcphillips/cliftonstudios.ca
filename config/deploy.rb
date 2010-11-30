set :application, "Clifton Studios"
set :repository,  "git://github.com/kimos/cliftonstudios.ca.git"
set :deploy_to, "/home/kevin/cliftonstudios.ca"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 10

default_run_options[:pty] = true

role :web, "cliftonstudios.ca"
role :app, "cliftonstudios.ca"
role :db,  "cliftonstudios.ca", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/assets #{release_path}/public/assets"

  %w{database.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end
