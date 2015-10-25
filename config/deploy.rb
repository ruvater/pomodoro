require "bundler/capistrano"
require "capistrano-rbenv"

server "shunt.ga", :web, :app, :db, primary: true

set :rbenv_ruby_version, "2.2.1"
set :application, "pomodoro"
set :user, "shunter"
set :port, 22 #your ssh port
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:ruvater/pomodoro.git" #your application repo (for instance git@github.com:user/application.git)
set :branch, "master"


default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: { no_release: true } do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    # symlink the unicorn init file in /etc/init.d/
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    # create a shared directory to keep files that are not in git and that are used for the application
    run "mkdir -p #{shared_path}/config"
    # if you're using mongoid, create a mongoid.template.yml file and fill it with your production configuration
    # and add your mongoid.yml file to .gitignore
    put File.read("config/mongoid.yml"), "#{shared_path}/config/mongoid.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    # symlink the shared mongoid config file in the current release
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Create MongoDB indexes"
  task :mongoid_indexes do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake db:mongoid:create_indexes", once: true
  end
  after "deploy:update", "deploy:mongoid_indexes"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

