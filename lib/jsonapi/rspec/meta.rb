module JSONAPI
  module RSpec
    module Meta
      if ::RSpec.respond_to?(:configure)
        ::RSpec::Matchers.define :have_meta do |val|
          match do |actual|
            actual.key?('meta') &&
              (!val || actual['meta'] == val)
          end
        end
      end
    end
  end
end
