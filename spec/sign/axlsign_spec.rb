# frozen_string_literal: true

require 'spec_helper'

describe Axlsign do
  describe '.crypto_sign_direct' do
    it 'calculates correctly' do
      input = [0] * 86
      input2 = [86, 111, 94, 93, 100, 103, 102, 91, 104, 90, 99, 110, 99, 111,
                87, 103, 103, 92, 105, 100, 86, 106]
      input3 = 22
      input4 = [97, 98, 95, 88, 91, 111, 89, 87, 88, 94, 107, 97, 96, 104, 104,
                97, 99, 97, 97, 96, 102, 105, 105, 103, 91, 86, 107, 98, 89,
                111, 100, 89, 94, 108, 100, 107, 92, 92, 102, 86, 90, 87, 94,
                98, 88, 92, 110, 97, 96, 102, 102, 104, 111, 101, 90, 87, 101,
                93, 91, 98, 96, 98, 93, 105]
      out = [183, 15, 97, 7, 194, 37, 245, 213, 172, 223, 233, 3, 67, 79, 76,
             67, 14, 33, 130, 4, 112, 65, 199, 60, 236, 120, 187, 109, 170,
             45, 202, 73, 245, 206, 211, 181, 132, 211, 21, 66, 232, 78, 109,
             121, 138, 47, 22, 89, 236, 129, 48, 100, 161, 231, 68, 235, 97,
             240, 129, 95, 7, 9, 173, 13, 86, 111, 94, 93, 100, 103, 102, 91,
             104, 90, 99, 110, 99, 111, 87, 103, 103, 92, 105, 100, 86, 106]
      calc = Axlsign.crypto_sign_direct(input, input2, input3, input4)[0]
      expect(calc.map(&:to_i)).to eq(out)
    end
  end

  describe '.sign' do
    it 'calculates signature' do
      message = WavesRubyClient::Conversion.base58_to_bytes(
        'Psm3kB61bTJnbBZo3eE6fBGg8vAEAG'
      )
      private_key = WavesRubyClient::Conversion.base58_to_bytes(
        '4nAEobwe4jB5Cz2FXDzGDEPge89YaWm9HhKwsFyeHwoc'
      )
      signature = Axlsign.sign(private_key, message, nil)
      expect(WavesRubyClient::Conversion.bytes_to_base58(signature)).to eq(
        '2HhyaYcKJVEPVgoPkjN3ZCVYKaobwxavLFnn75if6D95Nrc2jHAwX72inxsZpv9KVpMASqQfDB5KRqfkJutz5iav'
      )
    end
  end
end
