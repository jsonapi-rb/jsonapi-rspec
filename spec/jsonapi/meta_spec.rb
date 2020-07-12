require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_meta' do
  let(:doc) do
    {
      'meta' => {
        'one' => 'I',
        'two' => 'II',
        'three' => 'III'
      }
    }
  end
  context 'when providing no value' do
    it 'succeeds when meta is present' do
      expect(doc).to have_meta
    end

    it 'fails when meta is absent' do
      expect({}).not_to have_meta
    end
  end

  context 'when providing a value' do
    context 'with jsonapi indifferent hash enabled' do
      before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
      after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

      it do
        expect(doc).to have_meta(one: 'I')
      end
    end

    it 'succeeds when meta includes the value' do
      expect(doc).to have_meta('one' => 'I')
    end

    it 'fails when meta does not include the value' do
      expect(doc).not_to have_meta('one' => 'II')
    end

    it 'succeeds when meta exactly matches the value' do
      expect(doc).to have_meta({ 'one' => 'I', 'two' => 'II', 'three' => 'III' }).exactly
    end

    it 'succeeds when meta does not exactly match the value' do
      expect(doc).not_to have_meta({ 'one' => 'foo', 'two' => 'II', 'three' => 'III' }).exactly
    end

    it 'fails when meta is absent' do
      expect({}).not_to have_meta(foo: 'bar')
    end
  end
end
