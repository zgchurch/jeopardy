$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

require "bundler/capistrano"
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
load 'deploy/assets'


set :rvm_ruby_string, 'ruby-1.9.2'

set(:deploy_to) { "/home/#{user}/public_html/#{application}" }
set :rails_env, "production"
set :repository, "git://github.com/zgchurch/jeopardy.git"
role(:app) { application }
role(:web) { application }
role(:db, :primary => true)  { application }
set :scm, :git
set :scm_verbose, true
set :use_sudo, false
set :deploy_via, :remote_cache
set :symlinks, ['config/database.yml']
default_environment['RAILS_ENV'] = "production"

set :application, "jeopardy.msutriathlon.com"
set :user, "jeopardy"

## ssh forwarding options
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_shared do
    symlinks.each {|s| run "ln -nfs #{shared_path}/#{s} #{release_path}/#{s}" }
  end  
end

before "deploy:assets:precompile", "deploy:symlink_shared"
after "deploy", "deploy:cleanup"
after "deploy:symlink_shared", "deploy:migrate"
