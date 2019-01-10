require 'test_helper'

class Marketplace::TenderCommitteesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_tender_committee = marketplace_tender_committees(:one)
  end

  test "should get index" do
    get marketplace_tender_committees_url, as: :json
    assert_response :success
  end

  test "should create marketplace_tender_committee" do
    assert_difference('Marketplace::TenderCommittee.count') do
      post marketplace_tender_committees_url, params: { marketplace_tender_committee: { tender_id: @marketplace_tender_committee.tender_id, user_id: @marketplace_tender_committee.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show marketplace_tender_committee" do
    get marketplace_tender_committee_url(@marketplace_tender_committee), as: :json
    assert_response :success
  end

  test "should update marketplace_tender_committee" do
    patch marketplace_tender_committee_url(@marketplace_tender_committee), params: { marketplace_tender_committee: { tender_id: @marketplace_tender_committee.tender_id, user_id: @marketplace_tender_committee.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy marketplace_tender_committee" do
    assert_difference('Marketplace::TenderCommittee.count', -1) do
      delete marketplace_tender_committee_url(@marketplace_tender_committee), as: :json
    end

    assert_response 204
  end
end
