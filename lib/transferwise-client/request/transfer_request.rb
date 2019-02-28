module TransferwiseClient
  # Quote request class
  class TransferRequest < Request
    def initialize(quote, target_account, customer_transaction_id, reference)
      self['targetAccount'] = target_account
      self['quote'] = quote
      self['customerTransactionId'] = customer_transaction_id
      self['details'] = {}
      self['details']['reference'] = reference
    end

    def valid?
      true
    end

    def path
      'transfers'
    end
  end
end
