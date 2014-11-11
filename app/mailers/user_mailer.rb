class UserMailer < ActionMailer::Base
  default from: "noreply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.quiz_invitation.subject
  #
  def quiz_invitation(sender_name, user, quiz, is_new_user)
    @sender_name = sender_name
    @user = user
    @quiz = quiz
    @is_new_user = is_new_user
    @url = "192.168.1.104:3000"
    mail to: @user.email, subject: "2359 Media Quiz Invitation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
