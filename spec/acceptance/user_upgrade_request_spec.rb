require 'acceptance_helper'

resource "UserUpgradeRequest" do
  explanation 'User upgrade requests'
  
  # A specific endpoint
  route "/v1/users/upgrade_requests", 'Get all user upgrade requests' do
    let(:admin_user)  { FactoryBot.create :user, role: :admin }
    let(:admin_token) { Doorkeeper::AccessToken.create!(application_id: nil, resource_owner_id: admin_user.id).token }
    let(:admin_auth) { "Bearer #{admin_token}"}
      
      
    route_summary "This URL allows users to interact with all orders."
    # route_uri "/v1/users/upgrade_requests"
    # Which GET/POST params can be included in the request and what do they do?
    # parameter :sort, "Sort the response. Can be sorted by #{ResidencesIndex::SORTABLE_FIELDS.join(',')}. They are comma separated and include - in front to sort in descending order. Example: -rooms,cost"
    # parameter :number, "Which page number of results would you like.", scope: :page

    # let(:number) { 1 }
    # let(:sort) { "-rooms,cost" }

    # We can provide multiple examples for each endpoint, highlighting different aspects of them.
    get "Return all requests" do
      context '' do
        # Headers which should be included in the request
        header 'Accept', 'application/json'
        header 'Content-Type', 'application/json'
        header 'Authorization', :admin_auth
        
        explanation "Get all user upgrade requests in admin app"

        2.times do
         user = FactoryBot.create :user
         UserUpgradeRequest.create(user: user)
        end

        expected_response = JSON.parse(UserUpgradeRequest.all.to_json)

        example_request 'Get all requests' do
          expect(status).to eq(200)
        end
      end
    end
  end
end