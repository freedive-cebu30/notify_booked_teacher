module API
  class TeachersController < ApplicationController
    def index
      @teachers = current_user.teachers
    end
  end
end