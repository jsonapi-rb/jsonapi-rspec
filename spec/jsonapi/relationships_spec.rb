require 'spec_helper'

RSpec.describe JSONAPI::RSpec do
  let(:doc) do
    JSON.parse('{"relationships": {"videos": [], "images": []}}')
  end
  context '#have_relationships' do
    it 'succeeds when relationships are strings' do
      expect(doc).to have_relationships('videos', 'images')
    end

    it 'succeeds when relationships are symbols' do
      expect(doc).to have_relationships(:videos, :images)
    end
  end
end
