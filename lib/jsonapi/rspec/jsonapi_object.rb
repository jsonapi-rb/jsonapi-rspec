module JSONAPI
  module RSpec
    module JsonapiObject
      ::RSpec::Matchers.define :have_jsonapi_object do |val|
        match do |actual|
          actual.key?('jsonapi') &&
            (!val || actual['jsonapi'] == JSON.parse(JSON.generate(val)))
        end
      end
    end
  end
end
