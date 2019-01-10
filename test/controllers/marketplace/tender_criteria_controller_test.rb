require 'test_helper'

class Marketplace::TenderCriteriaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_tender_criterium = marketplace_tender_criteria(:one)
  end

  test "should get index" do
    get marketplace_tender_criteria_url, as: :json
    assert_response :success
  end

  test "should create marketplace_tender_criterium" do
    assert_difference('Marketplace::TenderCriterium.count') do
      post marketplace_tender_criteria_url, params: { marketplace_tender_criterium: { order: @marketplace_tender_criterium.order, title: @marketplace_tender_criterium.title } }, as: :json
    end

    assert_response 201
  end

  test "should show marketplace_tender_criterium" do
    get marketplace_tender_criterium_url(@marketplace_tender_criterium), as: :json
    assert_response :success
  end

  test "should update marketplace_tender_criterium" do
    patch marketplace_tender_criterium_url(@marketplace_tender_criterium), params: { marketplace_tender_criterium: { order: @marketplace_tender_criterium.order, title: @marketplace_tender_criterium.title } }, as: :json
    assert_response 200
  end

  test "should destroy marketplace_tender_criterium" do
    assert_difference('Marketplace::TenderCriterium.count', -1) do
      delete marketplace_tender_criterium_url(@marketplace_tender_criterium), as: :json
    end

    assert_response 204
  end
end
