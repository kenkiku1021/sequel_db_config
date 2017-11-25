# SequelDbConfig

Database configuration class for Sequel.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel_db_config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install -l pkg/sequel_db_config-0.0.1.gem

## Usage

### Config file
Default configuration file is "dbconfig.yaml".

```
db_driver: postgres
db_host: localhost
db_name: database_name
db_user: database_user
db_password: password
```

### Create Instance
SequelDbConfig::Config class includes Singleton module.
To create instance
```
dbconfig = SequelDbConfig::Config.instance
```

### Method
* connection_string : get database connection string for Sequel.
* load(file) : load configuration from specified YAML file.
* migrate(path, version) : exec migration on specified path.

## Contributing

1. Fork it ( https://github.com/kenkiku1021/sequel_db_config/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
