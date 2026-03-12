# frozen_string_literal: true

module WavesRubyClient
  # query data feed
  class DataFeed
    def self.current_price
      trade_history(1).first.price
    end

    # get history from data feed
    def self.trade_history(count = 10)
      path = "/transactions/exchange?amountAsset=#{WavesRubyClient::AMOUNT_ASSET.url_id}" \
             "&priceAsset=#{WavesRubyClient::PRICE_ASSET.url_id}&limit=#{count}"

      WavesRubyClient::Api.instance.call_data_feed(path)['data'].map do |entry|
        data = entry['data']
        WavesRubyClient::Order.new(
          id: data['id'],
          price: data['price'].to_f,
          timestamp: Time.parse(data['timestamp']),
          amount: data['amount'].to_f
        )
      end
    end
  end
end
