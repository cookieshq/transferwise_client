module TransferwiseClient
  # send request
  class Address < Hash
    def initialize(first_line, city, country_code, post_code, state, occupation)
      self['firstLine'] = first_line
      self['postCode'] = post_code
      self['city'] = city
      self['state'] = state
      self['occupation'] = occupation
      self['country'] = country_code
    end
  end
end
