RSpec.describe JSONAPI::RSpec do
  let(:doc) do
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
  end

  describe '#have_jsonapi_attributes' do
    it { expect(doc).to have_relationship(:posts) }
    it { expect(doc).to have_relationship('posts') }
    it { expect(doc).not_to have_relationship(:mails) }
    it { expect(doc).not_to have_relationship('mails') }
    it { expect(doc).to have_relationship(:posts).with_data({ 'id' => '1', 'type' => 'posts' }) }
    it { expect(doc).to have_relationship('posts').with_data({ 'id' => '1', 'type' => 'posts' }) }
    it { expect(doc).to have_relationship(:posts).with_data({ id: '1', type: 'posts' }) }
    it { expect(doc).to have_relationship('posts').with_data({ id: '1', type: 'posts' }) }
    it do
      expect(doc).to have_relationship(:comments).with_data(
        [{ 'id' => '1', 'type' => 'posts' }, { 'id' => '2', 'type' => 'hides' }]
      )
    end
    it do
      expect(doc).to have_relationship('comments').with_data(
        [{ 'id' => '1', 'type' => 'posts' }, { 'id' => '2', 'type' => 'hides' }]
      )
    end
    it do
      expect(doc).to have_relationship(:comments).with_data(
        [{ id: '1', type:  'posts' }, { id: '2', type: 'hides' }]
      )
    end
    it do
      expect(doc).to have_relationship('comments').with_data(
        [{ id: '1', type:  'posts' }, { id: '2', type: 'hides' }]
      )
    end
  end

  describe '#have_relationships' do
    it { expect(doc).to have_relationships(:posts, :comments) }
    it { expect(doc).to have_relationships('posts', 'comments') }
    it { expect(doc).not_to have_relationships(:posts, :comments, :mails) }
    it { expect(doc).not_to have_relationships('posts', 'comments', 'mails') }
  end
end
