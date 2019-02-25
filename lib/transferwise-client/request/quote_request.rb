module TransferwiseClient
  # Quote request class
  class QuoteRequest < Hash
    def initialize(source, target, target_amount)
      self['profile'] = '3431'
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
