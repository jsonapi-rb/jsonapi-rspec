require 'spec_helper'
RSpec.describe JSONAPI::RSpec, '#have_jsonapi_error' do
  let(:id) { '1' }
  let(:about_link) { 'http://about.me' }
  let(:status) { '200' }
  let(:code) { 'bad_thing' }
  let(:title) { 'A bad thing happened' }
  let(:detail) { 'The thing was bad' }
  let(:source) { pointer_source }
  let(:pointer) { '/data/attribute/title' }
  let(:pointer_source) { { 'pointer' => pointer } }
  let(:parameter) { 'page' }
  let(:parameter_source) { { 'parameter' => parameter } }
  let(:meta) do
    {
      "copyright" => "Copyright 2015 Example Corp.",
      "authors" => [
        "Yehuda Katz",
        "Steve Klabnik",
        "Dan Gebhardt",
        "Tyler Kellen"
      ]
    }
  end

  subject do
    {
      'errors' => [
        {
          'id' => id,
          'links' => { 'about' => about_link },
          'status' => status,
          'code' => code,
          'title' => title,
          'detail' => detail,
          'source' => source,
          'meta' => meta
        }
      ]
    }
  end

  it 'succeeds when errors key is present' do
    is_expected.to have_jsonapi_errors
  end

  it 'fails when errors key is absent' do
    expect({}).to_not have_jsonapi_errors
  end

  context 'chained methods' do
    describe '#count(count)' do
      it 'succeeds when errors count == count' do
        is_expected.to have_jsonapi_errors.count(1)
      end

      it 'fails when errors exclude ids' do
        expect({}).to_not have_jsonapi_errors.count(1)
      end
    end

    describe '#with_ids' do
      it 'succeeds when errors include ids' do
        is_expected.to have_jsonapi_errors.with_ids
      end

      it 'fails when errors exclude ids' do
        expect({}).to_not have_jsonapi_errors.with_ids
      end
    end

    describe '#with_about_link(about_link)' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_about_link(about_link)
      end

      it 'fails when errors exclude about_link' do
        expect({}).to_not have_jsonapi_errors.with_about_link(about_link)
      end
    end

    describe '#with_status(status)' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_status(status)
      end

      it 'fails when errors exclude status' do
        expect({}).to_not have_jsonapi_errors.with_status(status)
      end
    end

    describe '#with_code(code)' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_code(code)
      end

      it 'fails when errors exclude code' do
        expect({}).to_not have_jsonapi_errors.with_code(code)
      end
    end

    describe '#with_title(title)' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_title(title)
      end

      it 'fails when errors exclude title' do
        expect({}).to_not have_jsonapi_errors.with_title(title)
      end
    end

    describe '#with_detail(detail)' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_detail(detail)
      end

      it 'fails when errors exclude detail' do
        expect({}).to_not have_jsonapi_errors.with_detail(detail)
      end
    end

    describe '#with_source' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_source
      end

      it 'fails when errors exclude source' do
        expect({}).to_not have_jsonapi_errors.with_source
      end
    end

    describe '#on_pointer(pointer)' do
      let!(:source) { pointer_source }

      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.on_pointer(pointer)
      end

      it 'fails when errors exclude pointer_source' do
        expect({}).to_not have_jsonapi_errors.on_pointer(pointer)
      end
    end

    describe '#on_parameter(parameter)' do
      let!(:source) { parameter_source }

      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.on_parameter(parameter)
      end

      it 'fails when errors exclude parameter_source' do
        expect({}).to_not have_jsonapi_errors.on_parameter(parameter)
      end
    end

    describe '#with_meta(meta)' do
      it 'succeeds when errors include about links' do
        is_expected.to have_jsonapi_errors.with_meta(meta)
      end

      it 'fails when errors exclude meta' do
        expect({}).to_not have_jsonapi_errors.with_meta(meta)
      end
    end

    describe '#on_parameter and #on_pointer' do
      it 'raises a warning' do
        expect {
          expect({}).to have_jsonapi_errors.
            on_pointer(pointer).on_parameter(parameter)
        }.to raise_error(JSONAPI::RSpec::Errors::IncompatibleSourcesError)
      end
    end
  end
end
