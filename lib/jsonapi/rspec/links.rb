module JSONAPI
  module RSpec
    module Links
      ::RSpec::Matchers.define :have_link do |link|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          actual.key?('links') && actual['links'].key?(link.to_s) &&
            (!@val_set || actual['links'][link.to_s] == @val)
        end

        chain :with_value do |val|
          @val_set = true
          @val = val
        end
      end

      ::RSpec::Matchers.define :have_links do |*links|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('links')

          links.all? { |link| actual['links'].key?(link.to_s) }
        end
      end
    end
  end
end
