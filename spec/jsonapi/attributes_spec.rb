RSpec.describe JSONAPI::RSpec do
  json_doc =
    {
      'attributes' => {
        'one' => 1,
        'two' => 2,
        'four' => 3
      }
    }

  describe '#have_attribute' do
    context 'when attributes is present' do
      it { expect(json_doc).to have_attribute(:one) }
      it { expect(json_doc).not_to have_attribute(:five) }
    end

    context 'when attributes is not present' do
      it { expect({}).not_to have_attribute(:one) }
    end
  end

  describe '#have_jsonapi_attributes' do
    context 'when attributes is present' do
      it { expect(json_doc).to have_jsonapi_attributes(:one, 'two') }
      it { expect(json_doc).not_to have_jsonapi_attributes(:two, 'five') }
      it { expect(json_doc).to have_jsonapi_attributes(:one, :two, 'four').exactly }
      it { expect(json_doc).not_to have_jsonapi_attributes(:one).exactly }
    end

    context 'when attributes is not present' do
      it { expect({}).not_to have_jsonapi_attributes(:one, 'two') }
    end
  end
end
