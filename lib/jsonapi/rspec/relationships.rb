module JSONAPI
  module RSpec
    module Relationships
      ::RSpec::Matchers.define :have_relationship do |rel|
        match do |actual|
          return false unless (actual['relationships'] || {}).key?(rel.to_s)

          !@data_set || actual['relationships'][rel.to_s]['data'] == @data_val
        end

        chain :with_data do |val|
          @data_set = true
          @data_val = val
        end

        failure_message do |actual|
          if !(actual['relationships'] || {}).key?(rel.to_s)
            "expected #{actual} to have relationship #{rel}"
          else
            "expected #{actual['relationships'][rel.to_s]} " \
              "to have data #{@data_val}"
          end
        end
      end

      ::RSpec::Matchers.define :have_relationships do |*rels|
        match do |actual|
          return false unless actual.key?('relationships')

          rels.all? { |rel| actual['relationships'].key?(rel) }
        end
      end
    end
  end
end
