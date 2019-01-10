require 'test_helper'

class ClassificationCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code = classification_codes(:one)
  end

  test "should get index" do
    get classification_codes_url, as: :json
    assert_response :success
  end

  test "should create code" do
    assert_difference('ClassificationCode.count') do
      post classification_codes_url, params: { classification_code: @code }, as: :json
    end

    assert_response 201
  end

  test "should show code" do
    get classification_codes_url(@code), as: :json
    assert_response :success
  end

  test "should update code" do
    patch classification_codes_url(@code), params: { classification_code: @code }, as: :json
    assert_response 200
  end

  test "should destroy code" do
    assert_difference('ClassificationCode.count', -1) do
      delete classification_codes_url(@code), as: :json
    end

    assert_response 204
  end
end
