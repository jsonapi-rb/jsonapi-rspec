module JSONAPI
  module RSpec
    module Meta
      ::RSpec::Matchers.define :have_meta do |val|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('meta')
          return true unless val

          val = JSONAPI::RSpec.as_indifferent_hash(val)
          return false unless val <= actual['meta']

          !@exactly || (@exactly && val.size == actual['meta'].size)
        end

        chain :exactly do
          @exactly = true
        end
      end
    end
  end
end
