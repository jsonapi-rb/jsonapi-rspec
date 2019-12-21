module JSONAPI
  module RSpec
    module Attributes
      ::RSpec::Matchers.define :have_attribute do |attr|
        match do |actual|
          (actual['attributes'] || {}).key?(attr.to_s) &&
            (!@val_set || actual['attributes'][attr.to_s] == @val)
        end

        chain :with_value do |val|
          @val_set = true
          @val = val
        end
      end

      ::RSpec::Matchers.define :have_attributes do |*attrs|
        match do |actual|
          return false unless actual.key?('attributes')

          attrs.all? { |attr| actual['attributes'].key?(attr.to_s) }
        end
      end

      ::RSpec::Matchers.define :have_all_attributes_in do |*attrs|
        match do |actual|
          return true unless actual.key?('attributes')

          (actual['attributes'].keys - attrs.flatten.map(&:to_s)).empty?
        end
      end
    end
  end
end
