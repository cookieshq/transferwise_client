module TransferwiseClient
  # response
  class Response
    attr_reader :response
    def initialize(http_response)
      @response = JSON.parse(http_response.body)
    end
  end
end
