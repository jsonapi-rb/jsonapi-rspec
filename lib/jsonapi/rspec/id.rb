module JSONAPI
  module RSpec
    module Id
      if ::RSpec.respond_to?(:configure)
        ::RSpec::Matchers.define :have_id do |expected|
          match { |actual| actual['id'] == expected }
        end
      end
    end
  end
end
