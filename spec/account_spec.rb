require 'spec_helper.rb'

RSpec.describe TransferwiseClient::Account do
  describe '#build' do
    subject { TransferwiseClient::Account.new }
    before do
      subject.build('AUD', 'Account Holder Name', 'australian',
                    'bsbCode' => '083451', 'accountNumber' => '89976543')
    end
    it { expect(subject.instance_variable_get(:@account_request)).not_to be_nil }
  end

  describe '#save' do
    subject { TransferwiseClient::Account.new }
    before do
      subject.build('AUD', 'Account Holder Name', 'australian',
                    'bsbCode' => '083451', 'accountNumber' => '89976543')
    end

    it {
      transferwise_account = subject.save
      expect(transferwise_account.id).not_to be_nil
      expect(transferwise_account.accountHolderName).to eq('Account Holder Name')
      expect(transferwise_account.currency).to eq('AUD')
      expect(transferwise_account.type).to eq('australian')
      expect(transferwise_account.country).to eq('AU')
      expect(transferwise_account.details['legalType']).to eq('BUSINESS')
      expect(transferwise_account.details['bsbCode']).to eq('083451')
      expect(transferwise_account.details['accountNumber']).to eq('89976543')
    }
  end

  # TODO : Currently hitting network. Fix it.
  describe '#valid?' do
    subject { TransferwiseClient::Account.new }

    context 'when valid' do
      before do
        subject.build('AUD', 'Account Holder Name', 'australian',
                      'bsbCode' => '083451', 'accountNumber' => '89976543')
      end
      it { expect(subject.valid?).to be true }
    end

    context 'when invalid' do
      before do
        subject.build('AUD', 'Account Holder Name', 'australian',
                      'bsbCode' => '4535355', 'accountNumber' => '899765439998')
      end
      it {
        expect(subject.valid?).to be false
        expect(subject.errors).to include(
          { 'bsbCode' => 'bsbCode has not passed validation.' },
          'accountNumber' => 'accountNumber has not passed validation.'
        )
      }
    end
  end
end
