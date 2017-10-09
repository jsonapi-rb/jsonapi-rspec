require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_jsonapi_object' do
  context 'when providing no value' do
    it 'succeeds when jsonapi object is present' do
      expect('jsonapi' => { 'version' => '1.0'}).to have_jsonapi_object
    end

    it 'fails when jsonapi object is absent' do
      expect({}).not_to have_jsonapi_object
    end
  end

  context 'when providing a value' do
    it 'succeeds when jsonapi object matches' do
      expect('jsonapi' => { 'version' => '1.0' })
        .to have_jsonapi_object('version' => '1.0')
    end

    it 'fails when jsonapi object mismatches' do
      expect('jsonapi' => { 'version' => '2.0' })
        .not_to have_jsonapi_object('version' => '1.0')
    end

    it 'fails when jsonapi object is absent' do
      expect({}).not_to have_jsonapi_object('version' => '1.0')
    end
  end
end
