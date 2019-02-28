require 'spec_helper.rb'

RSpec.describe 'Integration Spec' do
  let(:auth_key) { '4a569d2b-264c-46ef-8280-7d8e96ac5b10' }
  let(:client) { TransferwiseClient::Client.connect(auth_key) }
  let(:profile) { client.profiles.find { |prof| prof.type == 'business' } }

  describe 'create account end to end' do
    it {
      account = client.create_account(profile.id, 'AUD', 'Full Name', 'australian',
                                      'bsbCode' => '083451', 'accountNumber' => '89976543')
      expect(account.id).not_to be_nil
    }
  end

  describe 'create quote end to end' do
    it {
      quote = client.create_quote(profile.id, 'GBP', 'EUR', 600.00)
      expect(quote.id).not_to be_nil
      expect(client.member_reference(quote.id)).to eq('P5473695')
    }
  end

  describe 'create transfer end to end' do
    it {
      target_account = client.create_account(profile.id, 'AUD', 'Full Name', 'australian',
                                             'bsbCode' => '083451', 'accountNumber' => '89976543')
      quote = client.create_quote(profile.id, 'GBP', 'AUD', 600.00)
      transfer = client.create_transfer(quote.id, target_account.id, SecureRandom.uuid,
                                        'Reference')
      expect(transfer.id).not_to be_nil
      payment_details = client.payment_details(quote.id)
      expect(payment_details['Account Name']).to eq('TransferWise')
      expect(payment_details['Account number']).to eq('53640809')
      expect(payment_details['Bank name']).to eq('Barclays')
      expect(payment_details['UK sort code']).to eq('20-95-61')
      expect(payment_details['sourceAmount']).not_to be_nil
    }
  end
end
