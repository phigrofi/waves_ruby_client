# frozen_string_literal: true

module WavesRubyClient
  # Access to waves api
  class Api
    include Singleton

    def call_matcher(path, method = :get, args = {})
      WavesRubyClient.try_many_times do
        call('/matcher' + path, method, args)
      end
    end

    def call_data_feed(path)
      response = HTTParty.get(WavesRubyClient::DATA_FEED_URL + path)
      JSON.parse(response.body)
    end

    def call(path, method = :get, args = {})
      response = HTTParty.send(method, WavesRubyClient::API_URL + path, args)
      JSON.parse(response.body)
    end
  end
end
