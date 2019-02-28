module TransferwiseClient
  # Create transfer
  class Transfer < OpenStruct
    attr_reader :errors

    def initialize(response)
      super(response)
    end

    # def fund(transfer_id)
    #   http_response = HttpRequest.new.fund_transfer(transfer_id)
    #   Response.new(http_response).response
    # end
  end
end
