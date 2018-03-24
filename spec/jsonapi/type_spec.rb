require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_type' do
  it 'succeeds when type matches' do
    expect('type' => 'foo').to have_type('foo')
  end

  it 'fails when type mismatches' do
    expect('type' => 'foo').not_to have_type('bar')
  end

  it 'fails when type is absent' do
    expect({}).not_to have_type('foo')
  end
end
