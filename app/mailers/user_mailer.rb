class UserMailer < ApplicationMailer

  def notify_teacher(teacher, user, params = {})
    @teacher = teacher
    @lesson_number = params[:lesson_number].present? ? params[:lesson_number] : nil
    @landing_page = params[:landing_page].present? ? params[:landing_page] : nil
    @m_landing_page =  params[:m_landing_page].present? ? params[:m_landing_page] : nil

    email = user.email
    mail to:  email, subject: "#{@teacher.name}が#{@lesson_number}スロット空いています"
  end
end
