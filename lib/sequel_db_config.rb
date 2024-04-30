require "sequel_db_config/version"
require "singleton"
require "yaml"
require "sequel"

module SequelDbConfig
  # Your code goes here...

  class Config
    include Singleton
    
    DEFAULT_CONFIG_FILE = "dbconfig.yaml"
    attr_reader :connection_string
    
    def initialize
      @connection_string = ""
      begin
        self.load(DEFAULT_CONFIG_FILE)
      rescue
      end
    end
    
    def load(file)
      begin
        File.open(file) do |f|
          conf = YAML.load(f.read)
          db_driver = conf["db_driver"]
          db_host = conf["db_host"]
          db_name = conf["db_name"]
          db_user = conf["db_user"]
          db_password = conf["db_password"]
          options = {
            max_connections: conf["max_connections"],
            pool_timeout: conf["pool_timeout"]  
          }
          option_string = self.make_options(options)

          @connection_string = "#{db_driver}://#{db_user}:#{db_password}@#{db_host}/#{db_name}#{option_string}"
        end
      rescue
        raise "Cannot open configuration file."
      end
    end

    def make_options(opts)
      option_string = ""
      opts.each do |key, value|
        if value
          if option_string == ""
            option_string = "?"
          else
            option_string += "&"
          end
          option_string += "#{key}=#{value}"
        end
      end
      option_string
    end

    # Execute migration
    # If version is nil, sequel will migrate to the latest version.
    def migrate(path, version = nil)
      if @connection_string == ""
        raise "Configuration is not loaded."
      end
      unless Dir.exist?(path)
        raise "Migration dir not exists. (#{path})"
      end
      Sequel.extension :migration
      db = Sequel.connect(@connection_string)
      if version
        Sequel::Migrator.run(db, path, target: version.to_i)
      else
        Sequel::Migrator.run(db, path)
      end
    end
  end
end
