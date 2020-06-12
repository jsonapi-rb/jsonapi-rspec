module JSONAPI
  module RSpec
    module Meta
      ::RSpec::Matchers.define :have_meta do |val|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          actual.key?('meta') &&
            (!val || actual['meta'] == val)
        end
      end
    end
  end
end
