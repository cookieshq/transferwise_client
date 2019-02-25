module TransferwiseClient
  # Create quote
  class Quote
    def build(source, target, target_amount)
      @quote_request = QuoteRequest.new(source, target, target_amount)
    end

    def valid?
      true
    end

    def create
      http_response = HttpRequest.new.send_request(@quote_request)
      Response.new(http_response).response
    end
  end
end
