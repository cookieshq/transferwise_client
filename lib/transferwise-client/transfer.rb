module TransferwiseClient
  # Create transfer
  class Transfer < OpenStruct
    def initialize(response)
      super(response)
    end
  end
end
