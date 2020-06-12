require 'rspec/matchers'
require 'jsonapi/rspec/id'
require 'jsonapi/rspec/type'
require 'jsonapi/rspec/attributes'
require 'jsonapi/rspec/relationships'
require 'jsonapi/rspec/links'
require 'jsonapi/rspec/meta'
require 'jsonapi/rspec/jsonapi_object'

RSpec.configure do |c|
  c.add_setting :allow_symbolized_jsonapi, default: false
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
      return doc unless ::RSpec.configuration.allow_symbolized_jsonapi
      return doc.with_indifferent_access if doc.respond_to?(:with_indifferent_access)

      JSON.parse(JSON.generate(doc))
    end
  end
end
