class UserMailer < ActionMailer::Base
  default from: "railscasts@example.com"

  def deliver_welcome_email(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end
end
