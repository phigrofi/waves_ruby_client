# frozen_string_literal: true

module WavesRubyClient
  # Conversion Helpers
  module Conversion
    module ClassMethods # :nodoc:
      def long_to_bytes(long)
        long = long.to_i
        bytes = []
        8.times do
          bytes << (long & 255)
          long /= 256
        end
        bytes.reverse
      end

      def bytes_to_base58(bytes)
        BTC::Base58.base58_from_data(bytes.map(&:chr).join)
      end

      def base58_to_bytes(input)
        BTC::Base58.data_from_base58(input).bytes
      end
    end

    extend ClassMethods
    include ClassMethods
  end
end
