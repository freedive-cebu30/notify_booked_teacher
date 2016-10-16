class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = current_user.teachers
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
      Teacher.transaction do
        @teacher = Teacher.find_or_create_by(online_teacher_id: teacher_params[:online_teacher_id], service_name: teacher_params[:service_name])
        @teacher.name = teacher_params[:name]
        @teacher.save!
        favorite_teacher = FavoriteTeacher.find_or_create_by(user_id: current_user.id, teacher_id: @teacher.id)
        favorite_teacher.save!
      end

      respond_to do |format|
       format.html { redirect_to @teacher, notice: t('teacher.created') }
      end
    rescue => e
      logger.debug e
      respond_to do |format|
       format.html { render :new }
      end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    favorite_teacher = FavoriteTeacher.where(user_id: current_user.id).where(teacher_id: @teacher.id).first
    favorite_teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:name, :online_teacher_id, :service_name)
    end
end
