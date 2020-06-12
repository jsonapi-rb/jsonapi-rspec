RSpec.describe JSONAPI::RSpec, '#have_id' do
  json_doc = { 'id' => 'foo' }
  symbol_doc = { id: 'foo' }

  describe '#have_id' do
    [json_doc, symbol_doc].each do |doc|
      subject { doc }
      before(:each) { RSpec.configuration.allow_symbolized_jsonapi = (doc == symbol_doc) }

      it { is_expected.to have_id('foo') }
      it { is_expected.not_to have_id('bar') }
    end
    it 'is expected not to have id "foo" when id is not present' do
      expect({}).not_to have_id('foo')
    end
  end
end
