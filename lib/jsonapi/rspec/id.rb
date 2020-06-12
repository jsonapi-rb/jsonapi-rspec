module JSONAPI
  module RSpec
    module Id
      ::RSpec::Matchers.define :have_id do |expected|
        match do |actual|
          JSONAPI::RSpec.as_indifferent_hash(actual)['id'] == expected
        end
      end
    end
  end
end
