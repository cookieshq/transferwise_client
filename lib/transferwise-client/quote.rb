module TransferwiseClient
  # Create quote
  class Quote < OpenStruct
    attr_reader :errors

    def initialize(response)
      super(response)
    end
  end
end
