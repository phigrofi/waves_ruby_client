# frozen_string_literal: true

module WavesRubyClient
  # get waves and btc balance
  class Wallet
    def self.balance
      WavesRubyClient.try_many_times do
        url = ['/orderbook', WavesRubyClient::AMOUNT_ASSET.url_id,
               WavesRubyClient::PRICE_ASSET.url_id, 'tradableBalance',
               WavesRubyClient::WAVES_ADDRESS].join('/')
        res = WavesRubyClient::Api.instance.call_matcher(url)
        { waves: res['WAVES'].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR,
          btc: res[WavesRubyClient::Asset.btc.url_id].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR }
      end
    end
  end
end
