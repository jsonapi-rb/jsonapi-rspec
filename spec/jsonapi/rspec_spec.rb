require 'securerandom'
require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#as_indifferent_hash' do
  let(:doc) do
    {
      id: SecureRandom.uuid,
      list: [
        { one: 1, 'one + one' => :two }
      ],
      hash: { key: :value, 'another key' => 'another value' }
    }
  end

  it do
    expect(JSONAPI::RSpec.as_indifferent_hash(doc)).not_to eq(
      JSON.parse(JSON.generate(doc))
    )
  end

  context 'with jsonapi indifferent hash enabled' do
    before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
    after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

    it do
      expect(JSONAPI::RSpec.as_indifferent_hash(doc)).to eq(
        JSON.parse(JSON.generate(doc))
      )
    end
  end
end
