def add_erb_yaml(file_path)
  raw_config = File.read(file_path)
  erb_config = ERB.new(raw_config).result(binding)
  return YAML.load(erb_config)
end

#require 'production_secret'
APP_CONFIG = add_erb_yaml( "#{RAILS_ROOT}/config/environments/all_config.yml" )
APP_CONFIG.merge!( add_erb_yaml("#{RAILS_ROOT}/config/environments/#{RAILS_ENV}_config.yml") )
