require 'rails_helper'

RSpec.describe "Marketplace::Collaborations", type: :request do
  describe "GET /marketplace_collaborations" do
    it "works! (now write some real specs)" do
      get marketplace_collaborations_path
      expect(response).to have_http_status(200)
    end
  end
end
