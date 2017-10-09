module JSONAPI
  module RSpec
    module Type
      if ::RSpec.respond_to?(:configure)
        ::RSpec::Matchers.define :have_type do |expected|
          match { |actual| actual['type'] == expected }
        end
      end
    end
  end
end
