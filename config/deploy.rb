# -*- encoding : utf-8 -*-

require 'rvm/capistrano'
require 'bundler/capistrano'

set :stages,       %w[development production]
set :default_stage, 'development'

require 'capistrano/ext/multistage'

# :user, :deploy_to etc. defined in other files (deploy/production.rb, etc)

set :application,  'ruby_template'
set :use_sudo,     false # (!)

set :scm,          :git
set :repository,   'https://github.com/kia84/ruby_template.git'
#set :branch,      'new_branch'

set :deploy_via,   :copy
set :copy_cache,   true
set :copy_exclude, %w(.git .gitignore)

role(:web)         { deploy_server }
role(:app)         { deploy_server }
role(:db, :primary => true) { deploy_server }

ssh_options[:forward_agent] = true
ssh_options[:port] = 22
default_run_options[:pty] = true
set :default_shell, '/bin/bash -l'

set (:rvm_ruby_string)   {:local}
set (:rvm_autolibs_flag) {'read-only'}       # more info: rvm help autolibs

set :keep_releases, 10

namespace :deploy do
  desc 'Start server'
  task :start do
    run "script/server start -p #{server_port}"
  end

  desc 'Stop server'
  task :stop do
    run "script/server stop -p #{server_port}"
  end

  desc 'Restart server'
  task :restart do
    run "script/server restart -p #{server_port}"
  end
end

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'

task :ask_production_confirmation do
  set(:confirmed) do
    puts <<-WARN

========================================================================

                           \033[1;31mWARNING\033[0m
  You're about to perform actions on production server!
  Please confirm that all your intentions are kind and friendly.

========================================================================

    WARN
    Capistrano::CLI.ui.ask(' Are you sure you want to continue? (YES/no) ') == 'YES'
  end

  unless fetch(:confirmed)
    puts "\nDeploy cancelled!"
    exit
  end
end

before 'production', :ask_production_confirmation
