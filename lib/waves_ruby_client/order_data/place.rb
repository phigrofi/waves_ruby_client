# frozen_string_literal: true

module WavesRubyClient
  module OrderData
    # Data for placing an order
    class Place
      include WavesRubyClient::Conversion

      attr_accessor :order

      def initialize(order)
        self.order = order
      end

      def data_with_signature
        data.merge(proofs: [signature])
      end

      private

      def signature
        sign_bytes = Axlsign.sign(
          base58_to_bytes(WavesRubyClient::WAVES_PRIVATE_KEY),
          bytes_to_sign
        )
        bytes_to_base58(sign_bytes)
      end

      def expiration
        @expiration ||= 1.day.since.to_i * 1000
      end

      def timestamp
        @timestamp ||= Time.now.to_i * 1000
      end

      def data
        { orderType: order.type,
          assetPair: { amountAsset: order.amount_asset.id, priceAsset: order.price_asset.id },
          price: (order.price * WavesRubyClient::NUMBER_MULTIPLIKATOR).to_i,
          amount: (order.amount * WavesRubyClient::NUMBER_MULTIPLIKATOR).to_i,
          timestamp: timestamp,
          expiration: expiration,
          matcherFee: WavesRubyClient::MATCHER_FEE * WavesRubyClient::NUMBER_MULTIPLIKATOR,
          matcherPublicKey: WavesRubyClient::MATCHER_PUBLIC_KEY,
          senderPublicKey: WavesRubyClient::WAVES_PUBLIC_KEY }
      end

      def bytes_to_sign
        order_data = data
        [
          base58_to_bytes(order_data[:senderPublicKey]),
          base58_to_bytes(order_data[:matcherPublicKey]),
          order.amount_asset.to_bytes,
          order.price_asset.to_bytes,
          order.type == :buy ? 0 : 1,
          long_to_bytes(order_data[:price]),
          long_to_bytes(order_data[:amount]),
          long_to_bytes(timestamp),
          long_to_bytes(order_data[:expiration]),
          long_to_bytes(order_data[:matcherFee])
        ].flatten
      end
    end
  end
end
