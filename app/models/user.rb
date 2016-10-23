class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :favorite_teachers
  has_many :teachers, through: :favorite_teachers

  validate :check_teacher_limit


  private
  def check_teacher_limit
    if teacher_limit < teacher_count
      errors[:base] << "#{I18n.t('validation.teacher_limit') + teacher_limit.to_s}"
    end
  end
end
