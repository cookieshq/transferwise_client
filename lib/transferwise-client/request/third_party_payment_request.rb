module TransferwiseClient
  # Quote request class
  class ThirdPartyPaymentRequest < Request
    def initialize(quote, target_account, original_transfer_id, originator, reference)
      self['targetAccount'] = target_account
      self['quote'] = quote
      self['originalTransferId'] = original_transfer_id
      self['originator'] = originator
      self['details'] = {}
      self['details']['reference'] = reference
    end

    def path
      "profiles/#{PROFILE_ID}/third-party-transfers"
    end
  end
end
