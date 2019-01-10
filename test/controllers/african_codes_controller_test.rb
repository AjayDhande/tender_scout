require 'test_helper'

class AfricanCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code = african_codes(:one)
  end

  test "should get index" do
    get african_codes_url, as: :json
    assert_response :success
  end

  test "should create code" do
    assert_difference('AfricanCode.count') do
      post african_codes_url, params: { african_code: @code }, as: :json
    end

    assert_response 201
  end

  test "should show code" do
    get african_codes_url(@code), as: :json
    assert_response :success
  end

  test "should update code" do
    patch african_codes_url(@code), params: { african_code: @code }, as: :json
    assert_response 200
  end

  test "should destroy code" do
    assert_difference('AfricanCode.count', -1) do
      delete african_codes_url(@code), as: :json
    end

    assert_response 204
  end
end
