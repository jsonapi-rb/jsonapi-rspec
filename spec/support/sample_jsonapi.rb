require 'active_support/core_ext/hash/indifferent_access'

module SampleJsonapi # rubocop:disable Metrics/ModuleLength
  SAMPLE_JSONAPI = {
    'jsonapi' => {
      'version' => '1.0'
    },
    'links' => {
      'self' => 'http://example.com/articles',
      'next' => 'http://example.com/articles?page[offset]=2',
      'last' => 'http://example.com/articles?page[offset]=10'
    },
    'data' => [
      {
        'type' => 'articles',
        'id' => '1',
        'attributes' => {
          'title' => 'JSON API paints my bikeshed!'
        },
        'relationships' => {
          'author' => {
            'links' => {
              'self' => 'http://example.com/articles/1/relationships/author',
              'related' => 'http://example.com/articles/1/author'
            },
            'data' => {
              'type' => 'people',
              'id' => '9'
            }
          },
          'comments' => {
            'links' => {
              'self' => 'http://example.com/articles/1/relationships/comments',
              'related' => 'http://example.com/articles/1/comments'
            },
            'data' => [
              {
                'type' => 'comments',
                'id' => '5'
              },
              {
                'type' => 'comments',
                'id' => '12'
              }
            ]
          }
        },
        'links' => {
          'self' => 'http://example.com/articles/1'
        }
      }
    ],
    'included' => [
      {
        'type' => 'people',
        'id' => '9',
        'attributes' => {
          'first-name' => 'Dan',
          'last-name' => 'Gebhardt',
          'twitter' => 'dgeb'
        },
        'links' => {
          'self' => 'http://example.com/people/9'
        }
      },
      {
        'type' => 'comments',
        'id' => '5',
        'attributes' => {
          'body' => 'First!'
        },
        'relationships' => {
          'author' => {
            'data' => {
              'type' => 'people',
              'id' => '2'
            }
          }
        },
        'links' => {
          'self' => 'http://example.com/comments/5'
        }
      },
      {
        'type' => 'comments',
        'id' => '12',
        'attributes' => {
          'body' => 'I like XML better'
        },
        'relationships' => {
          'author' => {
            'data' => {
              'type' => 'people',
              'id' => '9'
            }
          }
        },
        'links' => {
          'self' => 'http://example.com/comments/12'
        }
      }
    ],
    'meta' => {
      'totalPages' => 13,
      'numberOfViews' => 25
    }
  }.freeze

  # document formats for rspec as_indifferent_hash testing

  def document
    SAMPLE_JSONAPI
  end

  def symbolized_document
    symbolize_keys(SAMPLE_JSONAPI)
  end

  def indifferent_document
    SAMPLE_JSONAPI.with_indifferent_access
  end

  def symbolize_keys(doc)
    newdoc = doc.transform_keys(&:to_sym)
    newdoc.transform_values! do |val|
      if val.respond_to?('transform_keys!')
        symbolize_keys(val)
      elsif val.is_a?(Array)
        symbolize_array(val)
      else
        val
      end
    end
  end

  def symbolize_array(array)
    array.map do |element|
      next unless element.respond_to?('transform_keys!') ||
                  element.respond_to?('each')

      symbolize_keys(element)
    end
  end
end
