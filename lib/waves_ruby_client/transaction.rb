# frozen_string_literal: true

module WavesRubyClient
  # Access unconfirmed transactions
  class Transaction
    def self.unconfirmed
      WavesRubyClient::Api.instance.call_node('/transactions/unconfirmed')
    end

    # own unconfirmed exchange transactions
    def self.my_unconfirmed_exchanges
      unconfirmed.select do |transaction|
        next unless transaction['type'] == 7

        transaction['order1']['senderPublicKey'] == WavesRubyClient::WAVES_PUBLIC_KEY ||
          transaction['order2']['senderPublicKey'] == WavesRubyClient::WAVES_PUBLIC_KEY
      end
    end
  end
end
