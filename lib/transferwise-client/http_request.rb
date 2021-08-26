module TransferwiseClient
  # send request
  class HttpRequest
    def initialize(auth_key = nil)
      @auth_key = auth_key
    end

    def send_post_request(request)
      if request.api_version.present?
        custom_endpoint = endpoint.gsub("v1", request.api_version)
      else
        custom_endpoint = endpoint
      end

      url = URI("#{custom_endpoint}/#{request.path}")
      puts "............................... #{url}"

      post_response = http_post(url, request.to_h.to_json)

      puts ".1.............................. #{post_response.response.header}"
      if post_response.response.header["x-2fa-approval-result"] == 'REJECTED' && post_response.response.header["x-2fa-approval"].present?

        ott = post_response.response.header["x-2fa-approval"]

        puts ".2.............................. #{post_response.response}"
        puts "..3............................. #{ott}"

        return http_post(url, request.to_h.to_json, ott: ott)

      end

      post_response

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

    def http_post(url, body, ott = nil)

      key = File.read(sca_private_encryption_key)
      private_key = OpenSSL::PKey::RSA.new(key)
      signature = Base64.strict_encode64(private_key.sign(OpenSSL::Digest::SHA256.new, ott.to_s)) if ott.present?


      if ott.present?
        puts "..4............... #{signature}"
        puts "..4.1............... #{ott.to_s}"
      end

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http_request = Net::HTTP::Post.new(url)
      http_request['Content-Type'] = 'application/json'
      http_request['Authorization'] = "Bearer #{@auth_key}"
      http_request['x-2fa-approval'] = ott.to_s if ott.present?
      http_request['X-Signature'] = signature if ott.present?
      http_request.body = body
      puts ".5-h.............................. #{http_request}"
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

    def sca_private_encryption_key
      TransferwiseClient.configuration.sca_private_encryption_key
    end
  end
end
