module TransferwiseClient
  # Configure transferwise client
  class Configuration
    attr_accessor :endpoint
    attr_accessor :profile_id
    attr_accessor :auth_key

    def initialize
      @endpoint = 'sandbox'
    end

    def url
      return 'https://api.transferwise.com/v1' if @endpoint == 'live'

      'https://api.sandbox.transferwise.tech/v1'
    end

    def validation_url
      'https://api.transferwise.com/v1/validators'
    end
  end
end
