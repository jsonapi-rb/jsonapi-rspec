RSpec.describe JSONAPI::RSpec do
  json_doc =
    {
      'links' => {
        'self' => 'self_link',
        'related' => 'related_link'
      }
    }

  describe '#have_link' do
    context 'when links is present' do
      it { expect(json_doc).to have_link(:self) }
      it { expect(json_doc).to have_link(:self).with_value('self_link') }
      it { expect(json_doc).not_to have_link(:self).with_value('any_link') }
      it { expect(json_doc).not_to have_link(:any) }
    end

    context 'when links is not present' do
      it { expect({}).not_to have_link(:self) }
    end
  end

  describe '#have_links' do
    context 'when links is present' do
      it { expect(json_doc).to have_links(:self, 'related') }
      it { expect(json_doc).not_to have_links(:self, 'other') }
    end

    context 'when links is not present' do
      it { expect({}).not_to have_links(:self, 'related') }
    end
  end
end
