require 'spec_helper.rb'

RSpec.describe TransferwiseClient::Client do
  let(:auth_key) { '4a569d2b-264c-46ef-8280-7d8e96ac5b10' }
  let(:profile) { '3431' }
  subject { TransferwiseClient::Client.new(auth_key) }

  describe '#create_account' do
    let(:account_request) { TransferwiseClient::AccountRequest.new }
    before do
      account_request.profile_id = profile
      account_request.currency = 'AUD'
      account_request.type = 'australian'
      account_request.account_holder_name = 'Full Name'
      account_request.details = { 'bsbCode' => '083451', 'accountNumber' => '89976543' }
      account_request.details['legalType'] = 'PRIVATE'
    end

    it { expect(subject.create_account(account_request).id).to be_kind_of(Integer) }
  end
end
