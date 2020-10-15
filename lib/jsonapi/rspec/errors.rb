module JSONAPI
  module RSpec
    module Meta
      ::RSpec::Matchers.define :have_error do |error|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('errors')
          return false unless actual['errors'].is_a?(Array)

          return true if actual['errors'].any? && error.nil?

          error = JSONAPI::RSpec.as_indifferent_hash(error)

          actual['errors'].any? { |actual_error| error <= actual_error }
        end
      end
    end
  end
end
