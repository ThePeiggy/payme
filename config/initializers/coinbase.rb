COINBASE_CONFIG = YAML.load_file("#{::Rails.root}/config/coinbase.yml")[::Rails.env]
