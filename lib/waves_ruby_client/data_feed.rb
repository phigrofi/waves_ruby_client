module WavesRubyClient
  # query data feed
  class DataFeed
    def self.current_price
      trade_history(1).first.price
    end

    # get history from data feed
    def self.trade_history(count = 10)
      params = [
        '/trades',
        WavesRubyClient::AMOUNT_ASSET.url_id,
        WavesRubyClient::PRICE_ASSET.url_id,
        count
      ]

      WavesRubyClient::Api.instance.call_data_feed(params.join('/')).map do |entry|
        WavesRubyClient::Order.new(
          id: entry['id'],
          price: entry['price'].to_f,
          timestamp: Time.at(entry['timestamp'] / 1000),
          amount: entry['amount'].to_f
        )
      end
    end
  end
end
