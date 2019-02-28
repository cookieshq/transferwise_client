module TransferwiseClient
  # Create account
  class Account
    attr_reader :errors
    def build(currency, account_holder_name, type, extra_params)
      @account_request = AccountRequest.new(currency, account_holder_name, type, extra_params)
    end

    def valid?
      http_responses = HttpRequest.new.validation_request(@account_request.validation_params)
      validations = http_responses.map do |http_response|
        Response.new(http_response).response
      end
      errors = validations.map(&:errors)
      @errors = errors.compact.flatten.map { |error| { error['path'] => error['message'] } }
      @errors.empty?
    end

    def save
      return nil unless valid?

      http_response = HttpRequest.new.send_request(@account_request)
      Response.new(http_response).response
    end
  end
end
