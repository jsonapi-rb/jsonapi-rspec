# jsonapi-rspec

RSpec matchers for [JSON API](http://jsonapi.org).

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
  config.include JSONAPI::RSpec

  # Support for documents with mixed string/symbol keys. Disabled by default.
  config.jsonapi_indifferent_hash = true
end
```

## Usage and documentation

Available matchers:

* `expect(document['data']).to have_id('12')`
* `expect(document['data']).to have_type('users')`
* `expect(document['data']).to have_jsonapi_attributes(:name, :email)`
* `expect(document['data']).to have_jsonapi_attributes(:name, :email, :country).exactly`
* `expect(document['data']).to have_attribute(:name).with_value('Lucas')`
* `expect(document['data']).to have_relationships(:posts, :comments)`
* `expect(document['data']).to have_relationships(:posts, :comments, :likes).exactly`
* `expect(document['data']).to have_relationship(:posts).with_data([{ 'id' => '1', 'type' => 'posts' }])`
* `expect(document['data']['relationships']['posts']).to have_links(:self, :related)`
* `expect(document['data']).to have_link(:self).with_value('http://api.example.com/users/12')`
* `expect(document).to have_meta`
* `expect(document).to have_meta('foo' => 'bar')`
* `expect(document).to have_meta('foo' => 'bar', 'fum' => 'baz').exactly`
* `expect(document).to have_jsonapi_object`
* `expect(document).to have_jsonapi_object('version' => '1.0')`
* `expect(document).to have_error('status' => '422')`

### On matcher arguments...

**Note**: JSON:API spec requires JSON documents, thus attribute, relationship
and link matcher arguments will always be converted into strings for
consistency!!!

Basically, the tests bellow are absolutely equal:

```ruby
expect(document['data']).to have_id(12)
expect(document['data']).to have_id('12')

expect(document['data']).to have_type(:users)
expect(document['data']).to have_type('users')

expect(document['data']).to have_jsonapi_attributes(:name, :email)
expect(document['data']).to have_jsonapi_attributes('name', 'email')
```

The JSON:API spec also requires the `id` and `type` to be strings, so any other
argument passed will also be converted into a string.

If the document you are trying to test has mixed string/symbol keys, just
configure matchers to be indifferent in that regard, using the
`jsonapi_indifferent_hash = true` configuration option.

## Advanced examples

Checking for an included resource:

```ruby
expect(response_body['included'])
  .to include(have_type('posts').and have_id('1'))
```
## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jsonapi-rb/jsonapi-rspec

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

jsonapi-rspec is released under the [MIT License](http://www.opensource.org/licenses/MIT).
