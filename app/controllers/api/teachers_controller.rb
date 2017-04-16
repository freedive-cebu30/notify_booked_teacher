module API
  class TeachersController < ApplicationController
    skip_before_filter :authenticate_user!
    def index
      @teachers =
        case teacher_params[:service_name]
        when 'dmm'
          Teacher.dmm_teacher.all
        when 'rarejob'
          Teacher.rarejob_teacher.all
        else
          Teacher.all
        end
    end

    def create
      Teacher.transaction do
        @teacher = Teacher.find_or_create_by(online_teacher_id: teacher_params[:online_teacher_id],
                                                                              service_name: teacher_params[:service_name])
        @teacher.name = teacher_params[:name]
        @teacher.save!
        current_user = User.first
        favorite_teacher = FavoriteTeacher.find_or_create_by(user_id: current_user.id, teacher_id: @teacher.id)
        favorite_teacher.save!
        limit = current_user.teachers.count
        current_user.teacher_count = limit
        current_user.save!
      end
    end

    private

    def teacher_params
      params.permit(:name, :online_teacher_id, :service_name)
    end
  end
end