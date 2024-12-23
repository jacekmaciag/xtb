# XTB API client for Ruby

Xtb is a Ruby implementation of the [XTB broker API (xAPI) version 2.5.0](http://developers.xstore.pro/documentation/2.5.0).
At the time of writing this it's the latest version of the API.
This gem allows you to connect to the XTB broker and execute trades, get account information, and more.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add xtb

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install xtb

## Usage

### Configuration

Before you can connect to the XTB API, you need to configure the connection.

```ruby
Xtb.configure do |config|
  config.user_id = 'your_user_id'
  config.password = 'your_password'
end
```

NOTE: If you're using the Ruby on Rails framework, you can put the configuration in the `config/application.rb` file.

Here's a list of all available configuration options:
```ruby

```

### Connect to the XTB API

```ruby
require 'xtb'

# You're ready to use the API
Xtb::Command::CurrentUserData.call
```
Note that there is no need to log in first or log out afterwards. The gem handles the connection for you.

### Subscribing to the XTB API streaming commands

Your message handler class should implement the `#call` method that will be called when a message is received from the XTB API.

```ruby
Xtb.configure do |config|
  config.user_id = 'your_user_id'
  config.password = 'your_password'
  config.wss.message_handler = 'SomeClass'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jacekmaciag/xtb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
