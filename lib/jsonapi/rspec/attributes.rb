module JSONAPI
  module RSpec
    module Attributes
      ::RSpec::Matchers.define :have_attribute do |attr_name|
        match do |doc|
          doc = JSONAPI::RSpec.as_indifferent_hash(doc)
          attributes_node = doc['attributes']

          return false unless attributes_node

          @existing_attributes = attributes_node.keys
          @has_attribute = attributes_node.key?(attr_name.to_s)
          @actual = attributes_node[attr_name.to_s]

          return @actual == @expected if @has_attribute && @should_match_value

          @has_attribute
        end

        chain :with_value do |expected_value|
          @should_match_value = true
          @expected = expected_value
        end

        description do
          result = "have attribute #{attr_name.inspect}"
          result << " with value #{@expected.inspect}" if @should_match_value
          result
        end

        failure_message do |_doc|
          if @has_attribute
            "expected `#{attr_name}` attribute " \
              "to have value `#{@expected}` but was `#{@actual}`"
          else
            "expected attributes to include `#{attr_name}`. " \
              "Actual attributes were #{@existing_attributes}"
          end
        end

        diffable
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
