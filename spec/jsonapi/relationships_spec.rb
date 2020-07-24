require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_relationship(s)' do
  let(:doc) do
    {
      'relationships' => {
        'user' => {
          'data' => { 'id' => '1', 'type' => 'user' }
        },
        'comments' => {
          'data' => [
            { 'id' => '1', 'type' => 'comment' },
            { 'id' => '2', 'type' => 'comment' }
          ]
        }
      }
    }
  end

  it { expect(doc).not_to have_relationships('user', 'comments', 'authors') }
  it { expect(doc).to have_relationships('user', 'comments') }

  it { expect(doc).not_to have_relationship('authors') }
  it { expect(doc).to have_relationship('user') }

  it { expect(doc).to have_relationships('user', 'comments').exactly }
  it { expect(doc).not_to have_relationships('comments').exactly }

  it do
    expect(doc).to have_relationship('user').with_data(
      { 'id' => '1', 'type' => 'user' }
    )
  end

  it do
    expect(doc).to have_relationship('comments').with_data(
      [
        { 'id' => '1', 'type' => 'comment' },
        { 'id' => '2', 'type' => 'comment' }
      ]
    )
  end

  context 'with jsonapi indifferent hash enabled' do
    before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
    after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

    it { expect(doc).to have_relationships(:user, :comments) }

    it do
      expect(doc).to have_relationship('user').with_data(id: '1', type: :user)
    end

    it do
      expect(doc).to have_relationship('comments').with_data(
        [
          { id: '1', type: 'comment' },
          { id: '2', type: 'comment' }
        ]
      )
    end
  end
end
