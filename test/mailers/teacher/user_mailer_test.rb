require 'test_helper'

class Teacher::UserMailerTest < ActionMailer::TestCase
  test "send_connection_email" do
    mail = Teacher::UserMailer.send_connection_email
    assert_equal "Send connection email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
