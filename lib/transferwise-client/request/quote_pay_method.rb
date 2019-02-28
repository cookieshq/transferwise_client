module TransferwiseClient
  # Quote request class
  class QuotePayMethodRequest < Request
    def initialize(quote_id)
      @quote_id = quote_id
    end

    def valid?
      true
    end

    def path
      "quotes/#{@quote_id}/pay-in-methods"
    end
  end
end
