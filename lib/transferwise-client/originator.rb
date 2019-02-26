module TransferwiseClient
  # Create account
  class Originator < Hash
    def initialize(customer_id, full_name, business_reg_code, address, legal_type = 'BUSINESS')
      self['reference'] = customer_id
      self['legalEntityType'] = legal_type
      self['name'] = {}
      self['name']['fullName'] = full_name
      self['businessRegistrationCode'] = business_reg_code
      self['address'] = address
    end
  end
end
