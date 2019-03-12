require 'spec_helper.rb'

RSpec.describe TransferwiseClient::QuoteRequest do
  let(:profile_id) { '3231' }
  let(:source) { Faker::Currency.code }
  let(:target) { Faker::Currency.code }
  let(:target_amount) { Faker::Number.decimal }
  let(:type) { 'BALANCE_PAYOUT' }
  let(:rate_type) { 'FIXED' }

  subject { TransferwiseClient::QuoteRequest.new }
  before do
    subject.profile_id = profile_id
    subject.source = source
    subject.target = target
    subject.target_amount = target_amount
    subject.type = type
    subject.rate_type = rate_type
  end
  describe 'implements to_h' do
    it {
      expect(subject.to_h).to include(
        profile: profile_id,
        source: source,
        target: target,
        targetAmount: target_amount,
        type: type,
        rateType: rate_type
      )
    }
  end
end
