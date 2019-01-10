require 'test_helper'

class SearchMonitorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search_monitor = search_monitors(:one)
  end

  test "should get index" do
    get search_monitors_url, as: :json
    assert_response :success
  end

  test "should create search_monitor" do
    assert_difference('SearchMonitor.count') do
      post search_monitors_url, params: { search_monitor: { buyerList: @search_monitor.buyerList, codeList: @search_monitor.codeList, countryList: @search_monitor.countryList, keywordList: @search_monitor.keywordList, statusList: @search_monitor.statusList, tenderTitle: @search_monitor.tenderTitle, title: @search_monitor.title, valueFrom: @search_monitor.valueFrom, valueTo: @search_monitor.valueTo } }, as: :json
    end

    assert_response 201
  end

  test "should show search_monitor" do
    get search_monitor_url(@search_monitor), as: :json
    assert_response :success
  end

  test "should update search_monitor" do
    patch search_monitor_url(@search_monitor), params: { search_monitor: { buyerList: @search_monitor.buyerList, codeList: @search_monitor.codeList, countryList: @search_monitor.countryList, keywordList: @search_monitor.keywordList, statusList: @search_monitor.statusList, tenderTitle: @search_monitor.tenderTitle, title: @search_monitor.title, valueFrom: @search_monitor.valueFrom, valueTo: @search_monitor.valueTo } }, as: :json
    assert_response 200
  end

  test "should destroy search_monitor" do
    assert_difference('SearchMonitor.count', -1) do
      delete search_monitor_url(@search_monitor), as: :json
    end

    assert_response 204
  end
end
