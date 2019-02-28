module TransferwiseClient
  # Create account
  class Account < OpenStruct
    attr_reader :errors

    def initialize(response)
      super(response)
    end
  end
end
