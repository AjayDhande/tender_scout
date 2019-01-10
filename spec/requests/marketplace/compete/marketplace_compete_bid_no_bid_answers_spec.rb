require 'rails_helper'

RSpec.describe "Marketplace::Compete::BidNoBidAnswers", type: :request do
  describe "GET /marketplace_compete_bid_no_bid_answers" do
    it "works! (now write some real specs)" do
      get v1_marketplace_bid_no_bid_answers_path
      expect(response).to have_http_status(302)
    end
  end
end
