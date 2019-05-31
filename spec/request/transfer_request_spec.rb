require 'spec_helper.rb'

RSpec.describe TransferwiseClient::TransferRequest do
  let(:target_account) { Faker::Number.number }
  let(:quote) { Faker::Number.number }
  let(:customer_transaction_id) { Faker::Invoice.reference }
  let(:details) { {} }

  subject { TransferwiseClient::TransferRequest.new }
  before do
    subject.target_account = target_account
    subject.quote = quote
    subject.customer_transaction_id = customer_transaction_id
    subject.details = details
  end
  describe 'implements to_h' do
    it {
      expect(subject.to_h).to include(
        targetAccount: target_account,
        quote: quote,
        customerTransactionId: customer_transaction_id,
        details: details
      )
    }
  end
end
