# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::OrderData::UserOrders do
  subject do
    WavesRubyClient::OrderData::UserOrders.new
  end

  before do
    allow(SecureRandom).to receive(:random_bytes).and_return(double(bytes: nil))
    stub_const('WavesRubyClient::WAVES_PUBLIC_KEY',
               'FJuErRxhV9JaFUwcYLabFK5ENvDRfyJbRz8FeVfYpBLn')
    stub_const('WavesRubyClient::WAVES_PRIVATE_KEY',
               '9dXhQYWZ5468TRhksJqpGT6nUySENxXi9nsCZH9AefD1')
  end

  describe '#data_with_signature' do
    it 'calculates signed data' do
      allow(subject).to receive(:timestamp).and_return(1_489_592_282_029)
      expect(subject.data_with_signature).to eq(
        Timestamp: '1489592282029',
        Signature:       '3PoKt5nYJ5jjRps5xUqcPFdUrhigQ1qJ5Qf4gQnSBLAkKtbTNBkbPynqqiLBBGKSrXan3NsdMas8d7gqKgXsjyeP'
      )
    end
  end
end
