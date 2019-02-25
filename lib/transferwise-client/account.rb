module TransferwiseClient
  # Create account
  class Account
    def build(currency, account_holder_name, type,
              extra_params)
      @account_request = AccountRequest.new(currency, account_holder_name, type, extra_params)
    end

    def valid?
      http_responses = HttpRequest.new.validation_request(@account_request)
      validations = http_responses.map do |http_response|
        Response.new(http_response).response
      end
      errors = validations.map do |validation|
        validation['errors']
      end
      errors.compact.flatten.map { |error| { error['path'] => error['message'] } }.empty?
    end

    def create
      http_response = HttpRequest.new.send_request(@account_request)
      Response.new(http_response).response
    end
  end
end
