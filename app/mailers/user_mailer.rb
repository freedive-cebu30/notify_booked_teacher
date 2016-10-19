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
    if params[:service_name] == 'dmm'
     @landing_page = "http://eikaiwa.dmm.com/teacher/index/#{@teacher.online_teacher_id}/"
     @m_landing_page = "http://eikaiwa.dmm.com/teacher/schedule/#{@teacher.online_teacher_id}/"
    elsif params[:service_name] == 'rarejob'
     @landing_page = "http://www.rarejob.com/teacher_detail/#{@teacher.online_teacher_id}/"
     @m_landing_page = nil
    end
    email = user.email
    mail to:  email, subject: "#{@teacher.name}が#{@lesson_number}スロット空いています"
  end
end
