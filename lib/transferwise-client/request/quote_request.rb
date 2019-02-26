module TransferwiseClient
  # Quote request class
  class QuoteRequest < Request
    def initialize(source, target, target_amount)
      self['profile'] = PROFILE_ID
      self['rateType'] = 'FIXED'
      self['type'] = 'BALANCE_PAYOUT'
      self['source'] = source
      self['target'] = target
      self['targetAmount'] = target_amount
    end

    def path
      'quotes'
    end
  end
end
