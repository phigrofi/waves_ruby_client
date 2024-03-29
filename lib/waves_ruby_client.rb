# frozen_string_literal: true

require 'active_model'
require 'active_support/core_ext/object/instance_variables'
require 'active_support/duration'
require 'active_support/core_ext/numeric'
require 'httparty'
require 'singleton'

require 'sign/int32'
require 'sign/axlsign'

require 'btc/data'
require 'btc/base58'

require 'waves_ruby_client/version'
require 'waves_ruby_client/asset'
require 'waves_ruby_client/conversion'
require 'waves_ruby_client/api'
require 'waves_ruby_client/data_feed'
require 'waves_ruby_client/order_book'
require 'waves_ruby_client/order_data/place'
require 'waves_ruby_client/order_data/cancel'
require 'waves_ruby_client/order_data/user_orders'
require 'waves_ruby_client/order'
require 'waves_ruby_client/wallet'
require 'waves_ruby_client/transaction'

module WavesRubyClient
  WAVES_PUBLIC_KEY = ENV['WAVES_PUBLIC_KEY']
  WAVES_PRIVATE_KEY = ENV['WAVES_PRIVATE_KEY']
  WAVES_ADDRESS = ENV['WAVES_ADDRESS']

  DATA_FEED_URL = 'https://marketdata.wavesplatform.com/api'
  NODE_URL = ENV['WAVES_NODE_URL'] || 'https://nodes.wavesnodes.com'
  MATCHER_URL = ENV['WAVES_MATCHER_URL'] || 'https://matcher.waves.exchange'
  MATCHER_ADDRESS = ENV['WAVES_MATCHER_ADDRESS'] || '3PEjHv3JGjcWNpYEEkif2w8NXV4kbhnoGgu'
  MATCHER_PUBLIC_KEY = ENV['WAVES_MATCHER_PUBLIC_KEY'] || '9cpfKN9suPNvfeUNphzxXMjcnn974eme8ZhWUjaktzU5'

  BTC_ASSET_ID = '8LQW8f7P5d5PZM7GtZEBgaqRPGSzS3DfPuiXrURJ4AJS'
  WAVES_ASSET_ID = 'WAVES'

  MATCHER_FEE = 0.003
  NUMBER_MULTIPLIKATOR = 10**8

  PRICE_ASSET = WavesRubyClient::Asset.btc
  AMOUNT_ASSET = WavesRubyClient::Asset.waves

  OrderAlreadyFilled = Class.new(StandardError)

  # try method call several times
  def self.try_many_times(times = 5)
    tries ||= times
    yield
  rescue StandardError => e
    sleep(1)
    retry unless (tries -= 1).zero?
    raise e
  end
end
