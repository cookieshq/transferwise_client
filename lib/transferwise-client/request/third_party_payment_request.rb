module TransferwiseClient
  # Quote request class
  class ThirdPartyPaymentRequest < Hash
    def initialize(quote, target_account, original_transfer_id, customer_id, reference,
                   full_name, business_reg_code, address)
      self['targetAccount'] = target_account
      self['quote'] = quote
      self['originalTransferId'] = original_transfer_id
      self['originator'] = {}
      self['originator']['reference'] = customer_id
      self['originator']['legalEntityType'] = 'BUSINESS'
      self['originator']['name'] = {}
      self['originator']['name']['fullName'] = full_name
      self['originator']['businessRegistrationCode'] = business_reg_code
      self['originator']['address'] = address
      self['details'] = {}
      self['details']['reference'] = reference
    end

    def path
      "profiles/#{PROFILE_ID}/third-party-transfers"
    end
  end
end
