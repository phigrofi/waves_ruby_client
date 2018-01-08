
# frozen_string_literal: true

module WavesRubyClient
  module OrderData
    # Data for querying user orders
    class UserOrders
      include WavesRubyClient::Conversion

      def data_with_signature
        { Timestamp: timestamp.to_s,
          Signature: signature }
      end

      private

      def signature
        sign_bytes = Axlsign.sign(
          base58_to_bytes(WavesRubyClient::WAVES_PRIVATE_KEY),
          bytes_to_sign
        )
        bytes_to_base58(sign_bytes)
      end

      def timestamp
        @timestamp ||= Time.now.to_i * 1000
      end

      def bytes_to_sign
        base58_to_bytes(WavesRubyClient::WAVES_PUBLIC_KEY) + long_to_bytes(timestamp)
      end
    end
  end
end
