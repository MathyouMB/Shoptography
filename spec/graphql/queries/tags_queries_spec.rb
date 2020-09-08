require 'rails_helper'

RSpec.describe('Tag Queries') do
  before do
    prepare_query_variables({})
    prepare_context({})

    3.times do
      create(:tag)
    end
  end

  describe Queries::Tags do
    context 'when there are 3 tags in the database' do
      it 'returns a result with a length of 3' do
        prepare_query('{
                tags{
                    id
                }
            }')

        tags = graphql!['data']['tags']
        expect(tags.length).to(eq(3))
      end
    end
  end
end
