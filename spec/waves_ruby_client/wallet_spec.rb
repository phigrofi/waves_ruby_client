# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::Wallet do
  describe '.balance_btc' do
    it 'returns scaled amounts' do
      expect(WavesRubyClient::Api.instance).to receive(:call_node) do
        { 'balance' => 150_000_000_000 }
      end
      expect(described_class.balance_btc).to eq(1500)
    end
  end

  describe '.balance_waves' do
    it 'returns scaled amounts' do
      expect(WavesRubyClient::Api.instance).to receive(:call_node) do
        { 'balance' => 5_000_000_000 }
      end
      expect(described_class.balance_waves).to eq(50)
    end
  end
end
