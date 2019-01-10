require 'rails_helper'

describe "User functionality" do
  let!(:user)        { FactoryBot.create :user }
  let!(:admin_user)  { FactoryBot.create :user, role: :admin }
  let!(:token)       { Doorkeeper::AccessToken.create!(application_id: nil, resource_owner_id: user.id) }
  let!(:authorization) { { Authorization: "Bearer #{token.token}", 'Content-Type': 'application/json' } }
  let!(:admin_token)       { Doorkeeper::AccessToken.create!(application_id: nil, resource_owner_id: admin_user.id) }
  let!(:admin_authorization) { { Authorization: "Bearer #{admin_token.token}", 'Content-Type': 'application/json' } }
  
  it "disallow listing users for non-admin user" do
    get '/v1/users', headers: authorization
    expect(response).to have_http_status(403)
  end

  it "allow listing users for admin user" do
    get '/v1/users', headers: admin_authorization
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body).count).to eq(User.all.count)
  end

  it "allow user to send upgrade request" do
  	get '/v1/my/upgrade', headers: authorization
  	expect(response).to have_http_status(200)
  	expect(UserUpgradeRequest.count).to eq(1)
  end

  it "allow admin to see user upgrade requests" do
  	get '/v1/users/upgrade_requests', headers: admin_authorization
  	expect(response).to have_http_status(200)
  end

  it "allow user to send upgrade request and allow admin to see it" do
  	get '/v1/my/upgrade', headers: authorization
  	expect(response).to have_http_status(200)
  	expect(UserUpgradeRequest.count).to eq(1)
  	get '/v1/users/upgrade_requests', headers: admin_authorization
  	expect(JSON.parse(response.body).count).to eq(UserUpgradeRequest.count)
  end

  it "allow admin to approve upgrade request" do
  	get '/v1/my/upgrade', headers: authorization
  	expect(response).to have_http_status(200) #send request
  	expect(UserUpgradeRequest.count).to eq(1)
  	post "/v1/users/upgrade_requests/#{UserUpgradeRequest.last.id}/approve", headers: admin_authorization
  	expect(response).to have_http_status(200) #approve
  	user.reload
  	expect(user.role).not_to eq('free')
  end

  it "allow admin to delete upgrade request" do
  	get '/v1/my/upgrade', headers: authorization
  	expect(response).to have_http_status(200) #send request
  	expect(UserUpgradeRequest.count).to eq(1)
  	delete "/v1/users/upgrade_requests/#{UserUpgradeRequest.last.id}", headers: admin_authorization
  	expect(response).to have_http_status(200) #approve
  	expect(UserUpgradeRequest.count).to eq(0)
  end
end