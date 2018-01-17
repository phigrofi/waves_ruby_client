module WavesRubyClient
  # query data feed
  class DataFeed
    def self.current_price
      trade_history(1).first.price
    end

    # get history from data feed
    def self.trade_history(count = 10)
      WavesRubyClient::Api.instance.call_data_feed("/trades/WAVES/BTC/#{count}").map do |order|
        order['price'] = order['price'].to_f
        order['timestamp'] = order['timestamp'] / 1000
        order['amount'] = order['amount'].to_f
        WavesRubyClient::Order.new(order)
      end
    end
  end
end
