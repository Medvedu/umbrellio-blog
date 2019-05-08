ROM::Rails::Railtie.configure do |config|
  config.gateways[:default] = [:sql, ENV.fetch('database_url'),
                               username: ENV.fetch('database_username'),
                               password: ENV.fetch('database_password'),
                               max_connections: 64]
end
