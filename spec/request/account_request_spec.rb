require 'spec_helper.rb'

RSpec.describe TransferwiseClient::AccountRequest do
  let(:profile_id) { Faker::Number.number }
  let(:account_holder_name) { Faker::Name.name }
  let(:currency) { 'AUD' }
  let(:account_type) { 'australian' }
  let(:account_number) { Faker::Number.number }
  let(:bsb_code) { Faker::Number.number }

  subject { TransferwiseClient::AccountRequest.new }
  before do
    subject.profile_id = profile_id
    subject.currency = currency
    subject.type = account_type
    subject.account_holder_name = account_holder_name
    subject.details = { legalType: 'BUSINESS', accountNumber: account_number, bsbCode: bsb_code }
  end
  describe 'implements to_h' do
    it {
      expect(subject.to_h).to include(
        profile: profile_id,
        currency: currency,
        type: account_type,
        accountHolderName: account_holder_name,
        details: { legalType: 'BUSINESS', accountNumber: account_number, bsbCode: bsb_code }
      )
    }
  end

  describe 'validates account details' do
    let(:account_number) { '083451' }
    let(:bsb_code) { '89976543' }

    it {
      expect(subject.valid?).to be true
    }
  end
end
