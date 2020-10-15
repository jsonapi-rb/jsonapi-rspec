require 'json'
require 'rspec/matchers'
require 'rspec/core'
require 'jsonapi/rspec/id'
require 'jsonapi/rspec/type'
require 'jsonapi/rspec/attributes'
require 'jsonapi/rspec/relationships'
require 'jsonapi/rspec/links'
require 'jsonapi/rspec/meta'
require 'jsonapi/rspec/jsonapi_object'
require 'jsonapi/rspec/errors'

RSpec.configure do |c|
  c.add_setting :jsonapi_indifferent_hash, default: false
end

module JSONAPI
  module RSpec
    include Id
    include Type
    include Attributes
    include Relationships
    include Links
    include Meta
    include JsonapiObject

    def self.as_indifferent_hash(doc)
      return doc unless ::RSpec.configuration.jsonapi_indifferent_hash

      if doc.respond_to?(:with_indifferent_access)
        return doc.with_indifferent_access
      end

      JSON.parse(JSON.generate(doc))
    end
  end
end
