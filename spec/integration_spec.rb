require 'spec_helper.rb'

RSpec.describe 'Integration Spec' do
  let(:auth_key) { '4a569d2b-264c-46ef-8280-7d8e96ac5b10' }
  let(:client) { TransferwiseClient::Client.connect(auth_key) }
  let(:profile) { '3431' }

  xdescribe 'create transfer end to end' do
    it {
      account_request = TransferwiseClient::AccountRequest.new
      account_request.profile_id = profile
      account_request.currency = 'AUD'
      account_request.type = 'australian'
      account_request.account_holder_name = 'Full Name'
      account_request.details = { 'bsbCode' => '083451', 'accountNumber' => '89976543' }
      account_request.details['legalType'] = 'BUSINESS'
      target_account = client.create_account(account_request)

      quote_request = TransferwiseClient::QuoteRequest.new
      quote_request.profile_id = profile
      quote_request.rate_type = 'FIXED'
      quote_request.type = 'BALANCE_PAYOUT'
      quote_request.source = 'GBP'
      quote_request.target = 'AUD'
      quote_request.target_amount = 600.00
      quote = client.create_quote(quote_request)

      transfer_request = TransferwiseClient::TransferRequest.new
      transfer_request.target_account = target_account.id
      transfer_request.quote = quote.id
      transfer_request.customer_transaction_id = SecureRandom.uuid
      transfer_request.details = { reference: 'Reference' }

      transfer = client.create_transfer(transfer_request)
      puts transfer
      expect(transfer.id).not_to be_nil
    }
  end
end
