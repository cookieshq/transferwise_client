module TransferwiseClient
  # response
  class ResponseFactory
    attr_reader :response
    def initialize(http_response)
      response_object = JSON.parse(http_response.body)
      @response = Response.new(response_object) if response_object.is_a?(Hash)
      @response = response_object.map { |rs| Response.new(rs) } if response_object.is_a?(Array)
    end
  end
end
