require 'rails_helper'

RSpec.describe "Marketplace::BidNoBidQuestions", type: :request do
  describe "GET /marketplace_bid_no_bid_questions" do
    it "works! (now write some real specs)" do
      get v1_marketplace_bid_no_bid_questions_path
      expect(response).to have_http_status(302)
    end
  end
end
