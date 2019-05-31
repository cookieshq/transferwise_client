module TransferwiseClient
  # send request
  class HttpRequest
    def initialize(auth_key = nil)
      @auth_key = auth_key
    end

    def send_post_request(request)
      url = URI("#{endpoint}/#{request.path}")
      http_post(url, request.to_h.to_json)
    end

    def send_get_request(path)
      url = URI("#{endpoint}/#{path}")
      http_get(url)
    end

    def send_validation_request(validation_params)
      validation_params.map do |params|
        url = URI("#{validation_url}/#{params[:path]}")
        url.query = URI.encode_www_form(params[:params])
        http_get(url)
      end
    end

    private

    def http_post(url, body)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Post.new(url)
      http_request['Content-Type'] = 'application/json'
      http_request['Authorization'] = "Bearer #{@auth_key}"
      http_request.body = body
      http.request(http_request)
    end

    def http_get(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Get.new(url)
      http_request['Content-Type'] = 'application/json'
      http_request['Authorization'] = "Bearer #{@auth_key}" if @auth_key
      http.request(http_request)
    end

    def endpoint
      TransferwiseClient.configuration.url
    end

    def validation_url
      TransferwiseClient.configuration.validation_url
    end
  end
end
