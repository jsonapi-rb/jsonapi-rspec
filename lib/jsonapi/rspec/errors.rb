module JSONAPI
  module RSpec
    module Errors
      IncompatibleSourcesError = Class.new(StandardError)

      ::RSpec::Matchers.define :have_jsonapi_errors do
        match do |actual|
          actual ||= {}

          if @pointer && @parameter
            fail IncompatibleSourcesError.new('Only one source per example')
          end

          errors = actual['errors'] || {}

          on_parameter = true
          on_pointer = true
          if @check_on_parameter || @check_on_pointer
            source_type = 'pointer' if @pointer
            source_type = 'parameter' if @parameter
            errors.keep_if do |e|
              !e['source'].nil? &&
                e['source'][source_type] == (@pointer || @parameter)
            end

            if errors.empty?
              on_parameter = false if @parameter
              on_pointer = false if @pointer
            end
          end

          errors_present = actual.key?('errors')
          # Use these values to see if we need to run the check.
          # If the value is set to true the test will run
          correct_count = !@check_with_count
          with_ids = !@check_with_ids
          with_about_link = !@check_with_about_link
          with_status = !@check_with_status
          with_code = !@check_with_code
          with_title = !@check_with_title
          with_detail = !@check_with_detail
          with_source = !@check_with_source
          with_meta = !@check_with_meta

          correct_count ||= errors.count == @count

          with_ids ||= errors.map { |e| e['id'] }.count == errors.count

          with_about_link ||=
            errors.map { |e| e['links']['about'] }.include?(@about_link)

          with_status ||= errors.map { |e| e['status'] }.include?(@status)

          with_code ||= errors.map { |e| e['code'] }.include?(@code)

          with_title ||= errors.map { |e| e['title'] }.include?(@title)

          with_detail ||= errors.map { |e| e['detail'] }.include?(@detail)

          with_source ||= errors.map { |e| e['source'] }.any?

          with_meta ||= errors.map { |e| e['meta'] }.include?(@meta)

          [
            errors_present,
            on_parameter,
            on_pointer,
            correct_count,
            with_ids,
            with_about_link,
            with_status,
            with_code,
            with_title,
            with_detail,
            with_source,
            with_meta
          ].all?(true)
        end

        chain :count do |count|
          @check_with_count = true
          @count = count
        end

        chain :with_ids do
          @check_with_ids = true
        end

        chain :with_about_link do |about_link|
          @check_with_about_link = true
          @about_link = about_link
        end

        chain :with_status do |status|
          @check_with_status = true
          @status = status
        end

        chain :with_code do |code|
          @check_with_code = true
          @code = code
        end

        chain :with_title do |title|
          @check_with_title = true
          @title = title
        end

        chain :with_detail do |detail|
          @check_with_detail = true
          @detail = detail
        end

        chain :with_source do
          @check_with_source = true
        end

        chain :on_pointer do |pointer|
          @check_on_pointer = true
          @pointer = pointer
        end

        chain :on_parameter do |parameter|
          @check_on_parameter = true
          @parameter = parameter
        end

        chain :with_meta do |meta|
          @check_with_meta = true
          @meta = meta
        end
      end
    end
  end
end
