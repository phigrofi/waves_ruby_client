# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::OrderData::Place do
  let(:order) do
    WavesRubyClient::Order.new(amount: 2, price: 0.5, type: :sell)
  end

  subject do
    WavesRubyClient::OrderData::Place.new(order)
  end

  before do
    allow(SecureRandom).to receive(:random_bytes).and_return(double(bytes: nil))
    allow(subject).to receive(:timestamp).and_return(1_489_592_282_029)
    allow(subject).to receive(:expiration).and_return(1_492_184_282_029)
    allow(subject.order).to receive(:price_asset).and_return(
      WavesRubyClient::Asset.new(id: 'AaFXAN1WTM39XjECHW7DsVFixhq9yMGWHdM2ghr83Gmf')
    )
    allow(subject.order).to receive(:amount_asset).and_return(WavesRubyClient::Asset.waves)
    stub_const('WavesRubyClient::MATCHER_FEE', 0.01)
    stub_const('WavesRubyClient::MATCHER_PUBLIC_KEY',
               'Ei5BT6ZvKmB5VQLSZGo8mNkSXsTwGG4zUWjN7yu7iZo5')
    stub_const('WavesRubyClient::WAVES_PUBLIC_KEY',
               'FJuErRxhV9JaFUwcYLabFK5ENvDRfyJbRz8FeVfYpBLn')
    stub_const('WavesRubyClient::WAVES_PRIVATE_KEY',
               '9dXhQYWZ5468TRhksJqpGT6nUySENxXi9nsCZH9AefD1')
  end

  describe '#data_with_signature' do
    it 'calculates data with signature' do
      expect(subject.data_with_signature).to eq(
        amount: 200_000_000,
        assetPair: { amountAsset: '',
                     priceAsset: 'AaFXAN1WTM39XjECHW7DsVFixhq9yMGWHdM2ghr83Gmf' },
        expiration: 1_492_184_282_029,
        matcherFee: 1_000_000.0,
        matcherPublicKey: 'Ei5BT6ZvKmB5VQLSZGo8mNkSXsTwGG4zUWjN7yu7iZo5',
        orderType: :sell,
        price: 50_000_000,
        senderPublicKey: 'FJuErRxhV9JaFUwcYLabFK5ENvDRfyJbRz8FeVfYpBLn',
        proofs: ['5pzEHRrtfzH6mY64u8d1LX8rHufEvgnZ5YxGHFW33QUoi4Fv3ScWq7AnrEQMPaZjdR4uzoN9QHWoPTmZDVgpWUbw'],
        timestamp: 1_489_592_282_029
      )
    end
  end
end
