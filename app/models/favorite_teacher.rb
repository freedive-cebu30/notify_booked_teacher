class FavoriteTeacher < ApplicationRecord
  include DefaultDeleteFlagScope
  belongs_to :user
  belongs_to :teacher
end
