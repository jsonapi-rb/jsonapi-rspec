require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_id' do
  it 'succeeds when id matches' do
    expect('id' => 'foo').to have_id('foo')
  end

  it 'fails when id mismatches' do
    expect('id' => 'foo').not_to have_id('bar')
  end

  it 'fails when id is absent' do
    expect({}).not_to have_id('foo')
  end
end
