module JSONAPI
  module RSpec
    module Type
      ::RSpec::Matchers.define :have_type do |expected|
        match do |actual|
          JSONAPI::RSpec.as_indifferent_hash(actual)['type'] == expected
        end
      end
    end
  end
end
