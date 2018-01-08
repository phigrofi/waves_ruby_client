# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::Conversion do
  it 'converts from base58 and back' do
    x = WavesRubyClient::Conversion.base58_to_bytes('test')
    expect(WavesRubyClient::Conversion.bytes_to_base58(x)).to eq 'test'
  end

  describe '.long_to_bytes' do
    it 'converts long to bytes' do
      expect(WavesRubyClient::Conversion.long_to_bytes(515_126_126)).to eq(
        [0, 0, 0, 0, 30, 180, 51, 110]
      )
    end
  end

  describe '.base58_to_bytes' do
    it 'converts base58 to byte array' do
      x = WavesRubyClient::Conversion.base58_to_bytes('eRBWQTV4m1RwEfLtzrhyg3CMjWhpsPqAe')
      expect(x).to eq(
        [1, 154, 111, 104, 105, 163, 239, 25, 72, 17, 240, 65, 206, 120, 235, 129, 70, 16,
         247, 248, 180, 109, 210, 38, 95]
      )
    end
    it 'converts leading 1' do
      str = '132muJSEbwSRDaG7XhtS6yqCeaXYyWJtWpwg4RBTcpTd'
      x = WavesRubyClient::Conversion.base58_to_bytes(str)
      expect(WavesRubyClient::Conversion.bytes_to_base58(x)).to eq str
      expect(x.length).to eq(32)
    end
    it 'converts back to leading 1' do
      x = [0, 133, 42, 236, 210, 120, 43, 147, 91, 46, 43, 32, 212, 87, 1, 47, 43, 176,
           135, 165, 137, 115, 55, 27, 2, 229, 114, 94, 32, 4, 219, 124]
      expect(WavesRubyClient::Conversion.bytes_to_base58(x)).to eq(
        '132muJSEbwSRDaG7XhtS6yqCeaXYyWJtWpwg4RBTcpTd'
      )
    end
  end
end
