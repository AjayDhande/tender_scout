require 'test_helper'

class Marketplace::TenderCriteriaSectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marketplace_tender_criteria_section = marketplace_tender_criteria_sections(:one)
  end

  test "should get index" do
    get marketplace_tender_criteria_sections_url, as: :json
    assert_response :success
  end

  test "should create marketplace_tender_criteria_section" do
    assert_difference('Marketplace::TenderCriteriaSection.count') do
      post marketplace_tender_criteria_sections_url, params: { marketplace_tender_criteria_section: { order: @marketplace_tender_criteria_section.order, tender_id: @marketplace_tender_criteria_section.tender_id, title: @marketplace_tender_criteria_section.title } }, as: :json
    end

    assert_response 201
  end

  test "should show marketplace_tender_criteria_section" do
    get marketplace_tender_criteria_section_url(@marketplace_tender_criteria_section), as: :json
    assert_response :success
  end

  test "should update marketplace_tender_criteria_section" do
    patch marketplace_tender_criteria_section_url(@marketplace_tender_criteria_section), params: { marketplace_tender_criteria_section: { order: @marketplace_tender_criteria_section.order, tender_id: @marketplace_tender_criteria_section.tender_id, title: @marketplace_tender_criteria_section.title } }, as: :json
    assert_response 200
  end

  test "should destroy marketplace_tender_criteria_section" do
    assert_difference('Marketplace::TenderCriteriaSection.count', -1) do
      delete marketplace_tender_criteria_section_url(@marketplace_tender_criteria_section), as: :json
    end

    assert_response 204
  end
end
