class BasicIntegration < ActionDispatch::IntegrationTest
  test "The main app loads" do
    get "/"
    assert_response :success
  end
end