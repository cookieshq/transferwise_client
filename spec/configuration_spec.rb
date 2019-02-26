require 'spec_helper.rb'

RSpec.describe TransferwiseClient::Configuration do
  before do
    TransferwiseClient.configure do |config|
      config.profile_id = 'profile_id'
      config.auth_key = 'auth_key'
      config.endpoint = 'sandbox'
    end
  end
  describe 'allows configuring transferwise client' do
    it { expect(TransferwiseClient.configuration.auth_key).to eq('auth_key') }
    it { expect(TransferwiseClient.configuration.profile_id).to eq('profile_id') }
    it { expect(TransferwiseClient.configuration.endpoint).to eq('sandbox') }
    it {
      expect(TransferwiseClient.configuration.url).to eq('https://api.sandbox.transferwise.tech/v1')
    }
  end
end
