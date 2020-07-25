require 'spec_helper'

RSpec.describe JSONAPI::RSpec do
  let(:doc) do
    {
      'attributes' => {
        'one' => 1,
        'two' => 2,
        'four' => 3,
        'six' => { foo: 'bar' }
      }
    }
  end

  describe '#have_attribute' do
    it { expect(doc).to have_attribute(:one) }
    it { expect(doc).not_to have_attribute(:five) }
    it { expect(doc).to have_attribute(:one).with_value(1) }
    it { expect(doc).not_to have_attribute(:one).with_value(2) }
    it { expect(doc).to have_attribute(:six).with_value(foo: 'bar') }

    it 'rejects with an appropriate failure message' do
      expect { expect(doc).to have_attribute(:three) }
        .to raise_error(
          RSpec::Expectations::ExpectationNotMetError,
          'expected attributes to include `three`. ' \
          'Actual attributes were ["one", "two", "four", "six"]'
        )
    end

    it 'fails with a failure message for chained with_value' do
      expect { expect(doc).to have_attribute(:one).with_value(2) }
        .to raise_error(
          RSpec::Expectations::ExpectationNotMetError,
          /expected `one` attribute to have value `2` but was `1`/m
        )
    end

    it 'fails with a failure message and diff for chained with_value' do
      expect { expect(doc).to have_attribute(:six).with_value(bar: 'baz') }
        .to raise_error(
          RSpec::Expectations::ExpectationNotMetError,
          /expected `six` .* `{:bar=>"baz"}` but was `{:foo=>"bar"}`.*Diff:/m
        )
    end
  end

  describe '#have_jsonapi_attributes' do
    it { expect(doc).to have_jsonapi_attributes(:one, :two) }
    it { expect(doc).not_to have_jsonapi_attributes(:two, :five) }
    it { expect(doc).to have_jsonapi_attributes(:one, :two, :four, :six).exactly }
    it { expect(doc).not_to have_jsonapi_attributes(:one).exactly }
  end
end
