module TransferwiseClient
  # send request
  class HttpRequest
    URL = 'https://api.sandbox.transferwise.tech/v1'.freeze
    AUTH = '4a569d2b-264c-46ef-8280-7d8e96ac5b10'.freeze
    VALIDATION_URL = 'https://api.transferwise.com/v1/validators'.freeze

    def send_request(request)
      url = URI("#{URL}/#{request.path}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Post.new(url)
      http_request['Content-Type'] = 'application/json'
      http_request['Authorization'] = "Bearer #{AUTH}"
      http_request.body = request.to_json
      http.request(http_request)
    end

    def validation_request(request)
      request.validation_params.map do |params|
        url = URI("#{VALIDATION_URL}/#{params[:path]}")
        url.query = URI.encode_www_form(params[:params])
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http_request = Net::HTTP::Get.new(url)
        http_request['Content-Type'] = 'application/json'
        puts http_request.uri
        http.request(http_request)
      end
    end

    def fund_transfer(transfer_id)
      url = URI("#{URL}/transfers/#{transfer_id}/payments")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Post.new(url)
      http_request['Content-Type'] = 'application/json'
      http_request['Authorization'] = "Bearer #{AUTH}"
      http_request.body = { type: 'BALANCE' }.to_json
      http.request(http_request)
    end
  end
end
