# frozen_string_literal: true

module WavesRubyClient
  # get waves and btc balance
  class Wallet
    def self.balance_btc
      WavesRubyClient.try_many_times do
        url = ['/assets/balance', WavesRubyClient::WAVES_ADDRESS,
               WavesRubyClient::PRICE_ASSET.url_id].join('/')
        res = WavesRubyClient::Api.instance.call_node(url)
        res['balance'].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR
      end
    end

    def self.balance_waves
      WavesRubyClient.try_many_times do
        url = ['/addresses/balance', WavesRubyClient::WAVES_ADDRESS].join('/')
        res = WavesRubyClient::Api.instance.call_node(url)
        res['balance'].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR
      end
    end
  end
end
