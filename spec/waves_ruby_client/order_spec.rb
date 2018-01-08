# frozen_string_literal: true

require 'spec_helper'

describe WavesRubyClient::Order do
  subject do
    WavesRubyClient::Order.new(id: '195815', status: 'Accepted', amount: 20,
                               price: 0.0004, type: :buy)
  end

  before do
    stub_const('WavesRubyClient::WAVES_PUBLIC_KEY',
               'FJuErRxhV9JaFUwcYLabFK5ENvDRfyJbRz8FeVfYpBLn')
    stub_const('WavesRubyClient::WAVES_PRIVATE_KEY',
               '9dXhQYWZ5468TRhksJqpGT6nUySENxXi9nsCZH9AefD1')
  end

  describe '.all' do
    it 'returns users orders' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        [{ 'id' => 'jf2389j2', 'status' => 'Accepted' }]
      end
      order = described_class.all.first
      expect(order).to be_pending
      expect(order.id).to eq('jf2389j2')
    end
  end

  describe '.active' do
    it 'returns active users orders' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        [{ 'id' => 'jf2389j2', 'status' => 'Accepted' },
         { 'id' => 'f908j23gf', 'status' => 'Filled' }]
      end
      expect(described_class.active.count).to eq 1
    end
  end

  describe '#filled' do
    it 'refreshes order and returns filled amount' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        [{ 'id' => '195815', 'filled' => 500_000_000 }]
      end
      expect(subject.filled).to eq(5.0)
    end
  end

  describe '#place' do
    it 'places order' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        { 'status' => 'OrderAccepted', 'message' => { 'id' => 'placedid' } }
      end
      subject.place
      expect(subject.id).to eq('placedid')
    end
  end

  describe '#cancel' do
    it 'cancels order' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        { 'status' => 'OrderCanceled', 'message' => 'Ok' }
      end
      subject.cancel
    end
    it 'raises error when order is already filled' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        { 'status' => 'Failed', 'message' => 'Order is already Filled' }
      end
      expect { subject.cancel }.to raise_error(WavesRubyClient::OrderAlreadyFilled)
    end
  end

  describe '#delete' do
    it 'deletes order' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        { 'status' => 'OrderDeleted', 'message' => 'Ok' }
      end
      subject.delete
    end
  end

  describe '#refresh_status' do
    it 'refreshes order status' do
      expect(WavesRubyClient::Api.instance).to receive(:call_matcher) do
        { 'status' => 'newStatus' }
      end
      subject.refresh_status
      expect(subject.status).to eq('newStatus')
    end
  end
end
