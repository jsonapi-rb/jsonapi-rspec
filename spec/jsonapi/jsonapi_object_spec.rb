RSpec.describe JSONAPI::RSpec do
  json_doc =
    {
      'jsonapi' => {
        'version' => '1.0'
      }
    }

  describe '#have_jsonapi_object' do
    context 'when jsonapi is present' do
      it { expect(json_doc).to have_jsonapi_object }
      it { expect(json_doc).to have_jsonapi_object('version' => '1.0') }
      it { expect(json_doc).not_to have_jsonapi_object('version' => '2.0') }
    end

    context 'when jsonapi is not present' do
      it { expect({}).not_to have_jsonapi_object }
      it { expect({}).not_to have_jsonapi_object('version' => '1.0') }
    end
  end
end
