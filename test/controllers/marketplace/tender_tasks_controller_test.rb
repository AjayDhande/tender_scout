require 'test_helper'

class Marketplace::TenderQualificationCriteriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_tender_qualification_criteria = marketplace_tender_qualification_criterias(:one)
  end

  test "should get index" do
    get marketplace_tender_qualification_criterias_url, as: :json
    assert_response :success
  end

  test "should create marketplace_tender_qualification_criteria" do
    assert_difference('Marketplace::TenderQualificationCriteria.count') do
      post marketplace_tender_qualification_criterias_url, params: { marketplace_tender_qualification_criteria: { order: @marketplace_tender_qualification_criteria.order, title: @marketplace_tender_qualification_criteria.title, weight: @marketplace_tender_qualification_criteria.weight } }, as: :json
    end

    assert_response 201
  end

  test "should show marketplace_tender_qualification_criteria" do
    get marketplace_tender_qualification_criteria_url(@marketplace_tender_qualification_criteria), as: :json
    assert_response :success
  end

  test "should update marketplace_tender_qualification_criteria" do
    patch marketplace_tender_qualification_criteria_url(@marketplace_tender_qualification_criteria), params: { marketplace_tender_qualification_criteria: { order: @marketplace_tender_qualification_criteria.order, title: @marketplace_tender_qualification_criteria.title, weight: @marketplace_tender_qualification_criteria.weight } }, as: :json
    assert_response 200
  end

  test "should destroy marketplace_tender_qualification_criteria" do
    assert_difference('Marketplace::TenderQualificationCriteria.count', -1) do
      delete marketplace_tender_qualification_criteria_url(@marketplace_tender_qualification_criteria), as: :json
    end

    assert_response 204
  end
end
