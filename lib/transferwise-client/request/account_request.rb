module TransferwiseClient
  # Quote request class
  class AccountRequest < Request
    def initialize(profile_id, currency, account_holder_name, type,
                   details)
      self['profile'] = profile_id
      self['currency'] = currency
      self['type'] = type
      self['accountHolderName'] = account_holder_name
      self['details'] = {}
      self['details']['legalType'] = 'BUSINESS'
      details.each { |k, v| self['details'][k] = v }
    end

    def valid?
      http_responses = HttpRequest.new.validation_request(validation_params)
      validations = http_responses.map do |http_response|
        Response.new(http_response).response
      end
      errors = validations.map(&:errors)
      @errors = errors.compact.flatten.map { |error| { error['path'] => error['message'] } }
      @errors.empty?
    end

    def path
      'accounts'
    end

    private

    def validation_params
      VALIDATIONS[self['currency']].map do |validation|
        params = validation['queryKey'].map do |query_key|
          query_value = self['details'][query_key]
          [query_key, query_value] if query_value
        end.compact
        { path: validation['path'], params: params } unless params.empty?
      end.compact
    end
  end
end
