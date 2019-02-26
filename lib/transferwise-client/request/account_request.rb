module TransferwiseClient
  # Quote request class
  class AccountRequest < Request
    def initialize(currency, account_holder_name, type,
                   extra_params)
      self['profile'] = TransferwiseClient.configuration.profile_id
      self['currency'] = currency
      self['type'] = type
      self['accountHolderName'] = account_holder_name
      self['details'] = {}
      self['details']['legalType'] = 'BUSINESS'
      extra_params.each { |k, v| self['details'][k] = v }
    end

    def validation_params
      VALIDATIONS[self['currency']].map do |validation|
        params = validation['queryKey'].map do |query_key|
          query_value = self['details'][query_key]
          [query_key, query_value] if query_value
        end.compact
        { path: validation['path'], params: params } unless params.empty?
      end.compact
    end

    def path
      'accounts'
    end
  end
end
