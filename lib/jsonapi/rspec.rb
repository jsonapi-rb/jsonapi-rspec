require 'rspec/matchers'
require 'jsonapi/rspec/id'
require 'jsonapi/rspec/type'
require 'jsonapi/rspec/attributes'
require 'jsonapi/rspec/relationships'
require 'jsonapi/rspec/links'
require 'jsonapi/rspec/meta'
require 'jsonapi/rspec/jsonapi_object'

module JSONAPI
  module RSpec
    include Id
    include Type
    include Attributes
    include Relationships
    include Links
    include Meta
    include JsonapiObject
  end
end
