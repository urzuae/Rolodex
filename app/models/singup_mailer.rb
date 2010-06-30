class SingupMailer < ActionMailer::Base
  def singup_notification(user)
    recipients  user.email
    from        "no-reply@server.com"
    subject     "Thank you for singing in"
    body        "Thanks for singing up"
  end
end
