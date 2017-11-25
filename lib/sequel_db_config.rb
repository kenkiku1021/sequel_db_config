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
          @connection_string = "#{db_driver}://#{db_user}:#{db_password}@#{db_host}/#{db_name}"
        end
      rescue
        raise "Cannot open configuration file."
      end
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
