# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::Wallet do
  describe '.balance' do
    it 'returns scaled amounts' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        { 'WAVES' => 150_000_000_000,
          WavesRubyClient::BTC_ASSET_ID => 5_610_861 }
      end
      expect(described_class.balance).to eq(waves: 1500, btc: 0.05610861)
    end
  end
end
