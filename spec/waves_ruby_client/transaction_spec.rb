# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::Transaction do
  let(:transaction1) do
    { 'type' => 7,
      'id' => '44s4zmxGEYBzr3fxHXpHLxxzjRRtXkaVL6RjrMjJHvqA',
      'sender' => '3PJaDyprvekvPXPuAtxrapacuDJopgJRaU3',
      'senderPublicKey' => '7kPFrHDiGw1rCm7LPszuECwWYL3dMf6iMifLRDJQZMzy',
      'fee' => 300_000,
      'timestamp' => 1_515_328_110_009,
      'signature' => '3YAFGKGxxoRnHYtnedaS8ALdoXrfJp7NFamgM142enyna92Vpd8pw1SCsoAe6yXiJTXVUdgcUcmqx7ENCXTUKofu',
      'order1' => { 'id' => 'BALBVpYQn4AjqoP2VnqBqo4ZE1frw68yJnRuLsAkhPcr',
                    'senderPublicKey' => '8BK5UovuwUnGn3DjPvpzC1eXdHmx19vyJoTDgwDsvKSR',
                    'matcherPublicKey' => '7kPFrHDiGw1rCm7LPszuECwWYL3dMf6iMifLRDJQZMzy',
                    'assetPair' => { 'amountAsset' => nil,
                                     'priceAsset' => '8LQW8f7P5d5PZM7GtZEBgaqRPGSzS3DfPuiXrURJ4AJS' },
                    'orderType' => 'buy',
                    'price' => 79_695,
                    'amount' => 10_049_403_966,
                    'timestamp' => 1_515_328_109_917,
                    'expiration' => 1_517_920_109_917,
                    'matcherFee' => 300_000,
                    'signature' => '9nVymHY7ko66QpyxYRFZmohqMvsyZHGBUko6aQGYB8zmPaSMHNLsD2VV3VP6d8L8cQbhVTeRop9huQfHNQvvd2E' },
      'order2' => { 'id' => '8oLZpEJodQoeoLZAMWX9Bx2kkPVuP5LW9q5mXbJ2dwjc',
                    'senderPublicKey' => 'ERJQ5Wrdr7Bhv46283xrT5H3V9szb2XKsQpS7TJLiZcj',
                    'matcherPublicKey' => '7kPFrHDiGw1rCm7LPszuECwWYL3dMf6iMifLRDJQZMzy',
                    'assetPair' => { 'amountAsset' => nil,
                                     'priceAsset' => '8LQW8f7P5d5PZM7GtZEBgaqRPGSzS3DfPuiXrURJ4AJS' },
                    'orderType' => 'sell',
                    'price' => 79_695,
                    'amount' => 50_000_000_000,
                    'timestamp' => 1_515_327_477_659,
                    'expiration' => 1_517_055_477_659,
                    'matcherFee' => 300_000,
                    'signature' => '62izdYZGrRXiRKiNLbkKdfziqb3TL8sAPK1RJ9zZct9zmeZ6DgSEhuVVF912tYpZtEm2ND8qFbHWHvgXEzvo82oU' },
      'price' => 79_695,
      'amount' => 10_049_403_966,
      'buyMatcherFee' => 300_000,
      'sellMatcherFee' => 60_296 }
  end

  let(:transaction2) do
    { 'type' => 4,
      'id' => 'FrN82xC2SYzDnLZBxwXrvTuHNzRX28A1ksFNBbDiBdQC',
      'sender' => '3P6aJokn5F6zqZgSB2jUPTMrT5KbRYtwZkm',
      'senderPublicKey' => '7ZsZMahfw2AfutGftaf5PjecyG4Ai8499TMwYfh8HvzA',
      'fee' => 100_000,
      'timestamp' => 1_515_322_801_019,
      'signature' => '5dhueHEYq3zfBcqEAwp3MLfAsmKbXARAyzm721wJYpW5pKEevWAXgsEcxXqtJ9ZiJZbwvRRp2s39ra9WnjjtjUbF',
      'recipient' => '3PLrCnhKyX5iFbGDxbqqMvea5VAqxMcinPW',
      'assetId' => nil,
      'amount' => 29_983_983_558,
      'feeAsset' => nil,
      'attachment' => '' }
  end

  let(:transactions) { [transaction1, transaction2] }

  describe '.my_unconfirmed_exchanges' do
    it "returns user's unconfirmed exchanges" do
      stub_const('WavesRubyClient::WAVES_PUBLIC_KEY',
                 '8BK5UovuwUnGn3DjPvpzC1eXdHmx19vyJoTDgwDsvKSR')
      expect(WavesRubyClient::Api.instance).to receive(:call).and_return(transactions)
      expect(described_class.my_unconfirmed_exchanges).to eq([transaction1])
    end
  end
end
