# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::DataFeed do
  before do
    allow(WavesRubyClient::Api.instance).to receive(:call_data_feed) do
      { 'data' => [{ 'data' => { 'price' => 0.0007, 'timestamp' => '2018-01-18T14:13:23.123Z', 'amount' => 1.0 } }] }
    end
  end

  describe '.current_price' do
    it 'returns the current price' do
      expect(described_class.current_price).to eq(0.0007)
    end
  end

  describe '.trade_history' do
    it 'returns the trade history' do
      expect(described_class.trade_history(1).first.price).to eq(0.0007)
      expect(described_class.trade_history(1).first.timestamp.to_i).to eq(1_516_284_803)
    end
  end
end
