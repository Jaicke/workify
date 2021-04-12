require 'test_helper'

class Student::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get resources" do
    get student_users_resources_url
    assert_response :success
  end

end
