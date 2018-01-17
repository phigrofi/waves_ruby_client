# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::OrderData::Cancel do
  let(:order) do
    WavesRubyClient::Order.new(amount: 2, price: 0.5, type: :sell, id: '125987125')
  end

  subject do
    WavesRubyClient::OrderData::Cancel.new(order)
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
      expect(subject.data_with_signature).to eq(
        orderId: '125987125',
        sender: 'FJuErRxhV9JaFUwcYLabFK5ENvDRfyJbRz8FeVfYpBLn',
        signature: '3V4DgsG6BBGJmpA4FawFJwdMF8iv5bd5WSAUQqdyEAQCPPcdhq6W1MeANKhDK1LEhyt7wp7ghtZbFmsdvyupKWtc'
      )
    end
  end
end
