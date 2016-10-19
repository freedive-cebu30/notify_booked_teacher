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

  def notify_teacher(teacher, user, params = {})
    @teacher = teacher
    @lesson_number = params[:lesson_number] if params[:lesson_number]
    email = user.email
    mail to:  email, subject: "#{@teacher.name}が#{@lesson_number}空いています"
  end
end
