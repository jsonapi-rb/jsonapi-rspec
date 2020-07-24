module JSONAPI
  module RSpec
    module Attributes
      ::RSpec::Matchers.define :have_attribute do |attr|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          @attributes_node = actual['attributes']
          
          return false unless @attributes_node

          @has_attribute = @attributes_node.key?(attr.to_s)
          if @has_attribute && @should_match_value
            @actual_value = @attributes_node[attr.to_s]

            # Work nicely with diffable
            @actual = @actual_value
            @expected = @expected_value

            return @actual == @expected
          end
          @has_attribute
        end

        chain :with_value do |expected_value|
          @should_match_value = true
          @expected_value = expected_value
        end

        description do
          result = "have attribute #{attr.inspect}"
          if @should_match_value
            result << " with value #{@expected_value.inspect}"
          end
          result
        end

        failure_message do |actual|
          if @has_attribute
            "expected `#{attr}` attribute to have value `#{@expected}` but was `#{@actual}`"
          else
            "expected attributes to include `#{attr}`. Actual attributes were #{@attributes_node.keys}"
          end
        end

        diffable
        attr_reader :actual, :expected
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
