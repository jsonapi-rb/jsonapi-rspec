require 'spec_helper'

RSpec.describe JSONAPI::RSpec do
  let(:doc) do
    {
      'links' => {
        'self' => 'self_link',
        'related' => 'related_link'
      }
    }
  end

  context '#have_link' do
    it { expect(doc).to have_link(:self) }
    it { expect(doc).to have_link(:self).with_value('self_link') }
    it { expect(doc).not_to have_link(:self).with_value('any_link') }
    it { expect(doc).not_to have_link(:any) }
  end

  context '#have_links' do
    it { expect(doc).to have_links(:self, :related) }
    it { expect(doc).not_to have_links(:self, :other) }
  end
end
