require 'spec_helper.rb'

RSpec.describe TransferwiseClient::HttpRequest do
  let(:auth_key) { '4a569d2b-264c-46ef' }
  let(:request) { TransferwiseClient::FundRequest.new }
  subject { TransferwiseClient::HttpRequest.new(auth_key) }

  describe 'sends post request' do
    before do
      allow_any_instance_of(Net::HTTP).to receive(:request) { |_http, http_request| http_request }
      request.transfer_id = Faker::Number.number
      request.type = 'BALANCE'
    end
    it {
      expect(subject.send_post_request(request).uri.to_s).to eq(
        "#{TransferwiseClient.configuration.url}/transfers/#{request.transfer_id}/payments"
      )
    }
    it {
      expect(subject.send_post_request(request).body).to eq(request.to_h.to_json)
    }
    it {
      expect(subject.send_post_request(request)['Content-Type']).to eq('application/json')
    }
    it {
      expect(subject.send_post_request(request)['Authorization']).to eq("Bearer #{auth_key}")
    }
  end

  describe 'sends get request' do
    let(:url) { 'quote' }
    before do
      allow_any_instance_of(Net::HTTP).to receive(:request) { |_http, http_request| http_request }
    end
    it {
      expect(subject.send_get_request(url).uri.to_s).to eq(
        "#{TransferwiseClient.configuration.url}/#{url}"
      )
    }
    it {
      expect(subject.send_post_request(request)['Content-Type']).to eq('application/json')
    }
    it {
      expect(subject.send_post_request(request)['Authorization']).to eq("Bearer #{auth_key}")
    }
  end
end
