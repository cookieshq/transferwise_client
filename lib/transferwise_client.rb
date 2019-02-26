require 'ostruct'
require 'uri'
require 'net/http'
require 'json'
require 'yaml'

Dir[File.dirname(__FILE__) + '/transferwise-client/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/transferwise-client/request/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/transferwise-client/response/*.rb'].each { |f| require f }

TransferwiseClient::VALIDATIONS = YAML.load(
  IO.read(File.dirname(__FILE__) + '/../validations.yaml')
)

# Transferwise module
module TransferwiseClient
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
