module TransferwiseClient
  # send request
  class HttpRequest
    def send_request(request)
      url = URI("#{endpoint}/#{request.path}")
      http_post(url, request.to_json)
    end

    def validation_request(validation_params)
      validation_params.map do |params|
        url = URI("#{validation_url}/#{params[:path]}")
        url.query = URI.encode_www_form(params[:params])
        http_get(url)
      end
    end

    def fund_transfer(transfer_id)
      url = URI("#{URL}/transfers/#{transfer_id}/payments")
      http_post(url, { type: 'BALANCE' }.to_json)
    end

    private

    def http_post(url, body)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Post.new(url)
      http_request['Content-Type'] = 'application/json'
      http_request['Authorization'] = "Bearer #{auth_key}"
      http_request.body = body
      http.request(http_request)
    end

    def http_get(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Get.new(url)
      http_request['Content-Type'] = 'application/json'
      http.request(http_request)
    end

    def endpoint
      TransferwiseClient.configuration.url
    end

    def validation_url
      TransferwiseClient.configuration.validation_url
    end

    def auth_key
      TransferwiseClient.configuration.auth_key
    end
  end
end
