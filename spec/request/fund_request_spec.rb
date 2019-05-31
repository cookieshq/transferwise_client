require 'spec_helper.rb'

RSpec.describe TransferwiseClient::FundRequest do
  let(:transfer_id) { Faker::Number.number }
  let(:type) { 'BALANCE' }

  subject { TransferwiseClient::FundRequest.new }
  before do
    subject.transfer_id = transfer_id
    subject.type = type
  end
  describe 'implements to_h' do
    it {
      expect(subject.to_h).to include(
        type: type
      )
    }
  end
end
