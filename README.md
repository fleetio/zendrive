# Zendrive

Zendrive is a wrapper for the Zendrive Analytics API. More info about the Zendrive Analytics API can be found here at [http://docs.zendrive.com/en/latest/api/index.html](http://docs.zendrive.com/en/latest/api/index.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zendrive', git: "git://github.com/rarestep/zendrive.git"
```

And then execute:

    $ bundle

## Usage

Setup your API key in an initializer.
```
# config/initializers/zendrive.rb
Zendrive.configure do |config|
  config.api_key = 'YOUR_API_KEY'
end
```

Or inline:
```
Zendrive.api_key = 'YOUR_API_KEY'
```

Start using it!
```
# Get all drivers
$ Zendrive::Driver.all

# Get trips for a driver
$ driver = Zendrive::Driver.all.first
$ driver.trips

# Delete a trip
# Zendrive::Trip.delete(<driver_id>, <trip_id>)
$ Zendrive::Trip.delete(123, 456789)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/zendrive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
