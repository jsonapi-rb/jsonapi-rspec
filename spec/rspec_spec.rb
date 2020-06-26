require 'support/sample_jsonapi'

RSpec.describe JSONAPI::RSpec do
  include SampleJsonapi

  before(:each) { RSpec.configuration.allow_symbolized_jsonapi = enable }

  describe 'with allow_symbolized_jsonapi true' do
    let(:enable) { true }

    it 'returns a string keyed hash unchanged' do
      expect(JSONAPI::RSpec.as_indifferent_hash(document)).to eql(document)
    end

    it 'returns an indifferent hash unchanged' do
      expect(
        JSONAPI::RSpec.as_indifferent_hash(
          indifferent_document
        ).respond_to?(:with_indifferent_access)
      ).to be_truthy
    end

    it 'returns a symbolized hash with stringifyed keys' do
      expect(JSONAPI::RSpec.as_indifferent_hash(symbolized_document)).to eql(document)
    end
  end

  describe 'with allow_symbolized_jsonapi false' do
    let(:enable) { false }

    it 'returns a string keyed hash unchanged' do
      expect(JSONAPI::RSpec.as_indifferent_hash(document)).to eql(document)
    end

    it 'returns an indifferent hash unchanged' do
      expect(
        JSONAPI::RSpec.as_indifferent_hash(
          indifferent_document
        ).respond_to?(:with_indifferent_access)
      ).to be_truthy
    end

    it 'returns a symbolized hash unchanged' do
      expect(JSONAPI::RSpec.as_indifferent_hash(symbolized_document)).to eql(symbolized_document)
    end
  end
end
