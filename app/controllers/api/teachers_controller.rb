module API
  class TeachersController < ApplicationController
    skip_before_filter :authenticate_user!
    def index
      # @teachers = current_user.teachers
      @teachers = Teacher.all
    end
  end
end