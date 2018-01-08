# WavesRubyClient

With the waves ruby client gem, You can access some of the [Waves platform](https://wavesplatform.com/) API methods.

It was mainly build to create orders and can be used for automatic trading algorithms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'waves_ruby_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install waves_ruby_client

## Usage

The gem requires the following environment variables

* WAVES_PUBLIC_KEY: your waves public key
* WAVES_PRIVATE_KEY: your waves private key, necessary for signing requests
* WAVES_ADDRESS: your waves address

Optionally you can override the waves API URL (https://nodes.wavesnodes.com) and
the matcher public key (7kPFrHDiGw1rCm7LPszuECwWYL3dMf6iMifLRDJQZMzy) by setting the following environement variables:

* WAVES_API_URL
* WAVES_MATCHER_PUBLIC_KEY

### Order book

Shows current the current order book

```ruby
book = WavesRubyClient::OrderBook.btc_waves
book.refresh
book.bids
=> [{ price: 0.00082101, amount: 104 }, ...] # sorted by price descending
book.asks
=> [{ price: 0.00083, amount: 50 }, ...] # sorted by price ascending
```

### Order

An Order object has the following attributes:

* id
* price
* amount
* timestamp
* type (sell|buy)
* status (Accepted|PartiallyFilled|Filled|NotFound|Cancelled)

#### Get user orders

All orders:
```ruby
WavesRubyClient::Order.all
```

or orders with status (Accepted|PartiallyFilled)

```ruby
WavesRubyClient::Order.active
```

#### Place/Cancel/Delete limit order

```ruby
order = WavesRubyClient::Order.new(price: 0.0008, amount: 10)
order.place # raises exception if not successful
order.cancel
order.delete
```

#### Order status

```ruby
order = WavesRubyClient::Order.new(price: 0.0008, amount: 10)
order.place
order.refresh_status
order.status
=> 'Accepted'
order.pending?
=> true
```

### Transaction

WavesRubyClient can list unconfirmed transactions. This can be used to wait for
the transaction of a filled order after placing the next order.

```ruby
# order was filled
sleep(10) while WavesRubyClient::Transaction.my_unconfirmed_exchanges.any?

```

### Wallet

Lists user's balances for waves and bitcoins.

```ruby
WavesRubyClient::Wallet.balance
=> { waves: 5002.3, btc: 1200.3 }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/phigrofi/waves_ruby_client.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
