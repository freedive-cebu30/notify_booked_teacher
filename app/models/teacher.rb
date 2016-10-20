class Teacher < ApplicationRecord
  has_many :favorite_teachers
  has_many :users, through: :favorite_teachers
  validates :name,
                   presence: true,
                   length: { maximum: 20 }
  validates :online_teacher_id,
                    presence: true,
                   length: { maximum: 10 }
  validates :service_name,
                    presence: true,
                    inclusion: { in: %w(dmm rarejob sankei) }
end
