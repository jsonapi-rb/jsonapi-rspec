# jsonapi-rspec

RSpec matchers for [JSON API](http://jsonapi.org).

## Status

[![Gem Version](https://badge.fury.io/rb/jsonapi-rspec.svg)](https://badge.fury.io/rb/jsonapi-rspec)
[![Build Status](https://secure.travis-ci.org/jsonapi-rb/jsonapi-rspec.svg?branch=master)](http://travis-ci.org/jsonapi-rb/jsonapi-rspec?branch=master)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/jsonapi-rb/Lobby)

## Resources

* Chat: [gitter](http://gitter.im/jsonapi-rb)
* Twitter: [@jsonapirb](http://twitter.com/jsonapirb)

## Installation

Add the following to your application's Gemfile:
```ruby
gem 'jsonapi-rspec'
```
And then execute:
```
$ bundle
```

Add to your `spec/spec_helpers.rb`:

```ruby
# spec/spec_helpers.rb
require 'jsonapi/rspec'

RSpec.configure do |config|
  # ...
  config.include JSONAPI::RSpec
end
```

## Usage and documentation

Available matchers:

* `expect(document['data']).to have_id('12')`
* `expect(document['data']).to have_type('users')`
* `expect(document['data']).to have_attributes(:name, :email)`
* `expect(document['data']).to have_attribute(:name).with_value('Lucas')`
* `expect(document['data']).to have_relationships(:posts, :comments)`
* `expect(document['data']).to have_relationship(:posts).with_data([{ 'id' => '1', 'type' => 'posts' }])`
* `expect(document['data']['relationships']['posts']).to have_links(:self, :related)`
* `expect(document['data']).to have_link(:self).with_value('http://api.example.com/users/12')`
* `expect(document).to have_meta`
* `expect(document).to have_meta('foo' => 'bar')`
* `expect(document).to have_jsonapi_object`
* `expect(document).to have_jsonapi_object('version' => '1.0')`

## Advanced examples

Checking for an included resource:

```ruby
expect(response_body['included'])
  .to include(have_type('posts').and have_id('1'))
```

## License

jsonapi-rspec is released under the [MIT License](http://www.opensource.org/licenses/MIT).
