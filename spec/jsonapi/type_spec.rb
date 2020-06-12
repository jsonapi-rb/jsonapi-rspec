RSpec.describe JSONAPI::RSpec, '#have_type' do
  json_doc =
    {
      'type' => 'foo'
    }

  describe '#have_tyoe' do
    context 'when type is present' do
      it { expect(json_doc).to have_type('foo') }
      it { expect(json_doc).not_to have_type('bar') }
    end

    context 'when type is not present' do
      it { expect({}).not_to have_type('foo') }
    end
  end
end
