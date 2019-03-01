module TransferwiseClient
  # Create account
  class Account < OpenStruct
    def initialize(response)
      super(response)
    end
  end
end
