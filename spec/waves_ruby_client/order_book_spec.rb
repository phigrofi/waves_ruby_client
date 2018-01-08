# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::OrderBook do
  subject { WavesRubyClient::OrderBook.btc_waves }

  it 'returns scaled numbers' do
    expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
      { 'asks' => [{ 'price' => 50_000, 'amount' => 12_000_000_000 }],
        'bids' => [{ 'price' => 60_000, 'amount' => 13_000_000_000 }] }
    end
    subject.refresh
    expect(subject.asks).to eq([{ price: 0.0005, amount: 120 }])
    expect(subject.bids).to eq([{ price: 0.0006, amount: 130 }])
  end
end
