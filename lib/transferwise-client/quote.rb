module TransferwiseClient
  # Create quote
  class Quote < OpenStruct
    def initialize(response)
      super(response)
    end
  end
end
