require 'ostruct'
require 'uri'
require 'net/http'
require 'json'
require 'yaml'

Dir[File.dirname(__FILE__) + '/transferwise-client/request/*.rb'].each do |f|
  require f
end

Dir[File.dirname(__FILE__) + '/transferwise-client/response/*.rb'].each do |f|
  require f
end

Dir[File.dirname(__FILE__) + '/transferwise-client/*.rb'].each do |f|
  require f
end

TransferwiseClient::VALIDATIONS = YAML.load(
  IO.read(File.dirname(__FILE__) + '/../validations.yaml')
)

PROFILE_ID = '3431'