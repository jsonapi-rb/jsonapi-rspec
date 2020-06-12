module JSONAPI
  module RSpec
    module Attributes
      ::RSpec::Matchers.define :have_attribute do |attr|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          (actual['attributes'] || {}).key?(attr.to_s) &&
            (!@val_set || actual['attributes'][attr.to_s] == @val)
        end

        chain :with_value do |val|
          @val_set = true
          @val = val
        end
      end

      ::RSpec::Matchers.define :have_jsonapi_attributes do |*attrs|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('attributes')

          counted = (attrs.size == actual['attributes'].size) if @exactly

          (attrs.map(&:to_s) - actual['attributes'].keys).empty? &&
            (counted == @exactly)
        end

        chain :exactly do
          @exactly = true
        end
      end
    end
  end
end
