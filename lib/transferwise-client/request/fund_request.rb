module TransferwiseClient
  # Quote request class
  class FundRequest < Request
    attr_accessor :transfer_id
    attr_accessor :type

    def valid?
      true
    end

    def path
      "transfers/#{transfer_id}/payments"
    end

    def to_h
      { type: type }
    end
  end
end
