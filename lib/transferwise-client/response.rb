module TransferwiseClient
  # response
  class Response
    attr_reader :response
    def initialize(http_response)
      @response = OpenStruct.new(JSON.parse(http_response.body))
    end
  end
end
