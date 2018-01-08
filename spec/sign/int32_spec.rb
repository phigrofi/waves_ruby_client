# frozen_string_literal: true

require 'spec_helper'

describe Int32 do
  it 'has negative overflow' do
    x = Int32.new(2**31) + 1
    expect(x.to_i).to eq(-2_147_483_647)
  end
  it 'has positive overflow' do
    x = Int32.new(2**32) + 1
    expect(x.to_i).to eq(1)
  end

  describe '#r_shift_pos' do
    it 'does positive right shift' do
      expect(Int32.new(-7_483_647).r_shift_pos(8).to_i).to eq(16_747_983)
    end
  end
end
