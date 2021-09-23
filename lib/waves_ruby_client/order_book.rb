# frozen_string_literal: true

module WavesRubyClient
  # Orderbook for a pair of assets
  class OrderBook
    def self.btc_waves
      new(WavesRubyClient::Asset.waves, WavesRubyClient::Asset.btc)
    end

    attr_accessor :asset1, :asset2, :bids, :asks

    def initialize(asset1, asset2)
      self.asset1 = asset1
      self.asset2 = asset2
      self.bids = self.asks = []
    end

    def refresh
      order_book = WavesRubyClient::Api.instance.call_matcher(
        "/orderbook/#{asset1.url_id}/#{asset2.url_id}#getOrderBook"
      )
      self.asks = order_book['asks'].map { |order| scale(order) }
      self.bids = order_book['bids'].map { |order| scale(order) }
    end

    private

    def scale(order)
      { price: order['price'].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR,
        amount: order['amount'].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR }
    end
  end
end
