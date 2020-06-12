module JSONAPI
  module RSpec
    module JsonapiObject
      ::RSpec::Matchers.define :have_jsonapi_object do |val|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          val = JSONAPI::RSpec.as_indifferent_hash(val)

          actual.key?('jsonapi') && (!val || actual['jsonapi'] == val)
        end
      end
    end
  end
end
