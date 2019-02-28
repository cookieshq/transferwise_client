module TransferwiseClient
  # Quote request class
  class QuoteRequest < Request
    def initialize(profile_id, source, target, target_amount)
      self['profile'] = profile_id
      self['rateType'] = 'FIXED'
      self['type'] = 'REGULAR'
      self['source'] = source
      self['target'] = target
      self['targetAmount'] = target_amount
    end

    def valid?
      true
    end

    def path
      'quotes'
    end
  end
end
