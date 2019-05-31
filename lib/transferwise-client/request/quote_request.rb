module TransferwiseClient
  # Quote request class
  class QuoteRequest < Request
    attr_accessor :profile
    attr_accessor :source
    attr_accessor :target
    attr_accessor :target_amount
    attr_accessor :type
    attr_accessor :rate_type

    def valid?
      true
    end

    def path
      'quotes'
    end

    def to_h
      { profile: profile, source: source, target: target,
        targetAmount: target_amount, type: type, rateType: rate_type }
    end
  end
end
