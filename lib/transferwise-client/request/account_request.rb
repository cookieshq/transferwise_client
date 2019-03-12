module TransferwiseClient
  # Account request class
  class AccountRequest < Request
    attr_accessor :profile_id
    attr_accessor :currency
    attr_accessor :type
    attr_accessor :account_holder_name
    attr_accessor :details

    def valid?
      http_responses = HttpRequest.new.send_validation_request(validation_params)
      validations = http_responses.map do |http_response|
        Response.new(ResponseFactory.new(http_response).response)
      end
      errors = validations.map(&:errors)
      @errors = errors.compact.flatten.map { |error| { error['path'] => error['message'] } }
      @errors.empty?
    end

    def path
      'accounts'
    end

    def to_h
      {
        profile: profile_id, currency: currency,
        type: type, accountHolderName: account_holder_name,
        details: details
      }
    end

    private

    def validation_params
      VALIDATIONS[currency].map do |validation|
        params = validation['queryKey'].map do |query_key|
          query_value = details[query_key]
          [query_key, query_value] if query_value
        end.compact
        { path: validation['path'], params: params } unless params.empty?
      end.compact
    end
  end
end
