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

    def api_version
      "v3/profiles/#{profile_id}"
    end

    def to_h
      { type: type }
    end

    def profile_id
      TransferwiseClient.configuration.profile_id
    end
  end
end
