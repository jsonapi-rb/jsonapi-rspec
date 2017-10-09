module JSONAPI
  module RSpec
    module Type
      ::RSpec::Matchers.define :have_type do |expected|
        match { |actual| actual['type'] == expected }
      end
    end
  end
end
