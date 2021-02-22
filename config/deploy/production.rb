server '35.72.187.113', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '~/.ssh/id_rsa'
