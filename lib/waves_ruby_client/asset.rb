# frozen_string_literal: true

module WavesRubyClient
  class Asset
    include ActiveModel::Model
    attr_accessor :name, :id, :url_id

    def self.waves
      new(name: 'WAVES', id: '', url_id: WavesRubyClient::WAVES_ASSET_ID)
    end

    def self.btc
      new(name: 'BTC', id: WavesRubyClient::BTC_ASSET_ID,
          url_id: WavesRubyClient::BTC_ASSET_ID)
    end

    def to_bytes
      if name == WavesRubyClient::WAVES_ASSET_ID
        [0]
      else
        [1].concat(WavesRubyClient::Conversion.base58_to_bytes(id))
      end
    end
  end
end
