module WavesRubyClient
  # query data feed
  class DataFeed
    def self.current_price
      trade_history(1).first.price
    end

    # get history from data feed
    def self.trade_history(count = 10)
      WavesRubyClient::Api.instance.call_data_feed("/transactions/exchange?amountAsset=WAVES&limit=#{count}")['data'].map do |entry|
        order = entry['data']
        WavesRubyClient::Order.new(
          id: order['id'],
          price: order['price'].to_f,
          timestamp: Time.parse(order['timestamp']),
          amount: order['amount'].to_f
        )
      end
    end
  end
end
