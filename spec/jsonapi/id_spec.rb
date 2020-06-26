RSpec.describe JSONAPI::RSpec, '#have_id' do
  json_doc =
    {
      'id' => 'foo'
    }

  describe '#have_id' do
    context 'when id is present' do
      it { expect(json_doc).to have_id('foo') }
      it { expect(json_doc).not_to have_id('bar') }
    end
    context 'when id is not present' do
      it { expect({}).not_to have_id('foo') }
    end
  end
end
