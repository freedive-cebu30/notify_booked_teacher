class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation
    @greeting = "Hi"

    mail to: "jyouji1979@gmail.com"
    # mail to: "joji.urano@bibo.com.ph"
  end

  def notify_teacher(teacher, user)
    @teacher = teacher
    email = user.email
    mail to:  email, subject: "#{@teacher.name}が空いています"
  end
end
