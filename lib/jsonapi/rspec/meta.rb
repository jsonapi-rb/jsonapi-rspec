module JSONAPI
  module RSpec
    module Meta
      ::RSpec::Matchers.define :have_meta do |val|
        match do |actual|
          actual.key?('meta') &&
            (!val || actual['meta'] == JSON.parse(JSON.generate(val)))
        end
      end
    end
  end
end
