class Teacher < ApplicationRecord
  has_many :users
  validates :name,
                   presence: true,
                   length: { maximum: 20 }
  validates :online_teacher_id,
                    presence: true,
                   length: { maximum: 10 }
  validates :service_name,
                    presence: true,
                    inclusion: { in: %w(dmm) }
end
