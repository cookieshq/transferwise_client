module TransferwiseClient
  # Quote request class
  class AccountRequest < Hash
    def initialize(currency, account_holder_name, type,
                   extra_params)
      self['profile'] = PROFILE_ID
      self['currency'] = currency
      self['type'] = type
      self['accountHolderName'] = account_holder_name
      self['details'] = {}
      self['details']['legalType'] = 'BUSINESS'
      extra_params.each { |k, v| self['details'][k] = v }
    end

    def path
      'accounts'
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
  end
end
