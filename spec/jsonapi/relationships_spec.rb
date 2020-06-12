RSpec.describe JSONAPI::RSpec do
  json_doc =
    {
      'relationships' => {
        'posts' => {
          'data' => {
            'id' => '1',
            'type' => 'posts'
          }
        },
        'comments' => {
          'data' => [{
            'id' => '1',
            'type' => 'posts'
          }, {
            'id' => '2',
            'type' => 'hides'
          }]
        }
      }
    }

  describe '#have_relationship' do
    context 'when relationships is present' do
      it { expect(json_doc).to have_relationship('posts') }
      it { expect(json_doc).not_to have_relationship('mails') }
      it { expect(json_doc).to have_relationship('posts').with_data({ 'id' => '1', 'type' => 'posts' }) }
      it do
        expect(json_doc).to have_relationship('comments').with_data(
          [{ 'id' => '1', 'type' => 'posts' }, { 'id' => '2', 'type' => 'hides' }]
        )
      end
    end

    context 'when relationships is not present' do
      it { expect({}).not_to have_relationship('posts') }
    end
  end

  describe '#have_relationships' do
    context 'when relationships is present' do
      it { expect(json_doc).to have_relationships('posts', 'comments') }
      it { expect(json_doc).not_to have_relationships('posts', 'comments', 'mails') }
    end

    context 'when relationships is not present' do
      it { expect({}).not_to have_relationships('posts', 'comments') }
    end
  end
end
