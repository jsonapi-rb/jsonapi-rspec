module JSONAPI
  module RSpec
    module Relationships
      ::RSpec::Matchers.define :have_relationship do |rel|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless (actual['relationships'] || {}).key?(rel.to_s)

          !@data_set || actual['relationships'][rel.to_s]['data'] == @data_val
        end

        chain :with_data do |val|
          @data_set = true
          @data_val = JSONAPI::RSpec.as_indifferent_hash(val)
        end

        failure_message do |actual|
          if (actual['relationships'] || {}).key?(rel.to_s)
            "expected #{actual['relationships'][rel.to_s]} " \
              "to have data #{@data_val}"
          else
            "expected #{actual} to have relationship #{rel}"
          end
        end
      end

      ::RSpec::Matchers.define :have_relationships do |*rels|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('relationships')

          counted = (rels.size == actual['relationships'].keys.size) if @exactly

          rels.map(&:to_s).all? { |rel| actual['relationships'].key?(rel) } \
            && (counted == @exactly)
        end

        chain :exactly do
          @exactly = true
        end
      end
    end
  end
end
