module TransferwiseClient
  # response
  class Response < OpenStruct
    def initialize(http_response)
      super(http_response)
    end
  end
end
