# -*- encoding : utf-8 -*-

set :user,          'kia84'

set :server_env,    'development'
set :server_port,   '3000'

set :deploy_server, '192.168.0.27'
set :deploy_to,     "/home/#{user}/rails/#{application}"
