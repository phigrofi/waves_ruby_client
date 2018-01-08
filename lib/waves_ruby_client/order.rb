# frozen_string_literal: true

module WavesRubyClient
  # A limit order
  class Order
    include ActiveModel::Model

    JSON_HEADERS = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }.freeze

    attr_accessor :type, :amount, :id, :timestamp, :status, :price
    attr_writer :filled

    # get all orders for WAVES_PUBLIC_KEY
    def self.all
      url = ['/orderbook', WavesRubyClient::AMOUNT_ASSET.url_id,
             WavesRubyClient::PRICE_ASSET.url_id,
             'publicKey', WavesRubyClient::WAVES_PUBLIC_KEY].join('/')
      data = WavesRubyClient::OrderData::UserOrders.new.data_with_signature
      orders = WavesRubyClient::Api.instance.call_matcher(url, :get, headers: data)
      orders.map do |order_hash|
        attributes = %i[filled price amount].map do |attribute|
          { attribute => order_hash[attribute.to_s].to_f / WavesRubyClient::NUMBER_MULTIPLIKATOR }
        end.reduce({}, :merge)
        new(order_hash.slice('id', 'status', 'type', 'timestamp').merge(attributes))
      end
    end

    # get all orders waiting to be filled for WAVES_PUBLIC_KEY
    def self.active
      all.select { |o| o.status == 'Accepted' || o.status == 'PartiallyFilled' }
    end

    # order is waiting to be filled
    def pending?
      status != 'Filled' && status != 'PartiallyFilled'
    end

    # filled amount
    def filled
      refresh_from_collection
      @filled
    end

    # place order
    # any error is raised
    def place
      data = WavesRubyClient::OrderData::Place.new(self).data_with_signature
      res = WavesRubyClient::Api.instance.call_matcher('/orderbook', :post,
                                                       body: data.to_json,
                                                       headers: JSON_HEADERS)
      raise res.to_s unless res['status'] == 'OrderAccepted'
      self.id = res['message']['id']
      self
    end

    # cancel order
    # any error is raised
    def cancel
      res = remove('cancel')
      raise WavesRubyClient::OrderAlreadyFilled if res['message']&.match?(/Order is already Filled/)
      raise res.to_s unless res['status'] == 'OrderCanceled'
    end

    # delete order after it has been cancelled
    # any error is raised
    def delete
      res = remove('delete')
      raise res.to_s unless res['status'] == 'OrderDeleted'
    end

    def price_asset
      WavesRubyClient::PRICE_ASSET
    end

    def amount_asset
      WavesRubyClient::AMOUNT_ASSET
    end

    # query order status
    def refresh_status
      url = "/orderbook/#{amount_asset.url_id}/#{price_asset.url_id}/#{id}"
      response = WavesRubyClient::Api.instance.call_matcher(url, :get)
      self.status = response['status']
    end

    private

    # There is no api method to query data of a single order
    # So all orders are retrieved
    def refresh_from_collection
      order = self.class.all.select { |o| o.id == id }.first
      return unless order
      assign_attributes(order.instance_values)
    end

    def remove(action)
      data = WavesRubyClient::OrderData::Cancel.new(self).data_with_signature
      url = "/orderbook/#{amount_asset.url_id}/#{price_asset.url_id}/#{action}"
      WavesRubyClient::Api.instance.call_matcher(url, :post,
                                                 body: data.to_json,
                                                 headers: JSON_HEADERS)
    end
  end
end
