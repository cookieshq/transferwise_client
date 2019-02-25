module TransferwiseClient
  # Create transfer
  class Transfer
    def build(quote, target_account, customer_transaction_id, reference)
      @transfer_request = TransferRequest.new(
        quote, target_account, customer_transaction_id, reference
      )
    end

    def valid?
      true
    end

    def create
      http_response = HttpRequest.new.send_request(@transfer_request)
      Response.new(http_response).response
    end

    def fund(transfer_id)
      http_response = HttpRequest.new.fund_transfer(transfer_id)
      Response.new(http_response).response
    end
  end
end
