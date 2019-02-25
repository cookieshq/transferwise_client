module TransferwiseClient
  # Create transfer
  class ThirdPartyPayment
    def build(quote, target_account, original_transfer_id, customer_id, reference, full_name,business_reg_code, address)
      @third_party_request = ThirdPartyPaymentRequest.new(
        quote, target_account, original_transfer_id,
        customer_id, reference, full_name,business_reg_code, address
      )
    end

    def valid?
      true
    end

    def create
      http_response = HttpRequest.new.send_request(@third_party_request)
      Response.new(http_response).response
    end
  end
end
