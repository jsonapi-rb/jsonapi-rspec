require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_meta' do
  context 'when providing no value' do
    it 'succeeds when meta is present' do
      expect('meta' => {}).to have_meta
    end

    it 'fails when meta is absent' do
      expect({}).not_to have_meta
    end
  end

  context 'when providing a value' do
    it 'succeeds when meta matches' do
      expect('meta' => { foo: 'bar' }).to have_meta(foo: 'bar')
    end

    it 'fails when meta mismatches' do
      expect('meta' => { foo: 'bar' }).not_to have_meta(bar: 'baz')
    end

    it 'fails when meta is absent' do
      expect({}).not_to have_meta(foo: 'bar')
    end
  end
end
