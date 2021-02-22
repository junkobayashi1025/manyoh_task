server '172.31.32.200', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/junko/.ssh/id_rsa'
