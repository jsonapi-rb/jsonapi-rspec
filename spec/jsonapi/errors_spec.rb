require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_error' do
  let(:doc) do
    {
      'errors' => [
        {
          'status' => '422',
          'source' => { 'pointer' => '/data/attributes/firstName' },
          'title' => 'Invalid Attribute',
          'detail' => 'First name must contain at least three characters.'
        }
      ]
    }
  end

  context 'when providing no value' do
    it 'succeeds when errors are present' do
      expect(doc).to have_error
    end

    it 'fails when errors are missing' do
      expect({}).not_to have_error
      expect({ 'errors' => [] }).not_to have_error
    end
  end

  context 'when providing a value' do
    it do
      expect(doc).to have_error(
        'status' => '422',
        'source' => { 'pointer' => '/data/attributes/firstName' }
      )
    end

    it 'fails when meta is absent' do
      expect(doc).not_to have_error({ 'status' => '500' })
    end
  end
end
