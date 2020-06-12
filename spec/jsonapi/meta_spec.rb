RSpec.describe JSONAPI::RSpec do
  json_doc =
    {
      'meta' => {
        'foo' => 'bar'
      }
    }

  describe '#have_meta' do
    context 'when meta is present' do
      it { expect(json_doc).to have_meta }
      it { expect(json_doc).to have_meta('foo' => 'bar') }
      it { expect(json_doc).not_to have_meta('foo' => 'baz') }
    end

    context 'when meta is not present' do
      it { expect({}).not_to have_meta }
      it { expect({}).not_to have_meta('foo' => 'bar') }
    end
  end
end
