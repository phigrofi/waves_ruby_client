# frozen_string_literal: true

module WavesRubyClient
  module OrderData
    # Data for cancelling an order
    class Cancel
      include WavesRubyClient::Conversion

      attr_accessor :order

      def initialize(order)
        self.order = order
      end

      def data_with_signature
        { sender: WavesRubyClient::WAVES_PUBLIC_KEY,
          orderId: order.id,
          signature: signature }
      end

      private

      def signature
        sign_bytes = Axlsign.sign(
          base58_to_bytes(WavesRubyClient::WAVES_PRIVATE_KEY),
          bytes_to_sign
        )
        bytes_to_base58(sign_bytes)
      end

      def bytes_to_sign
        base58_to_bytes(WavesRubyClient::WAVES_PUBLIC_KEY) + base58_to_bytes(order.id)
      end
    end
  end
end
