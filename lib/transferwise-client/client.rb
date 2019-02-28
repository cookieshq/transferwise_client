module TransferwiseClient
  # Create quote
  class Client
    def self.connect(auth_key)
      @auth_key = auth_key
      HttpRequest.new
    end
  end
end
