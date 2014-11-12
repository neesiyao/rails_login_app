class QuizzesController < ApplicationController
  before_action :set_quiz,      only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :invited_user,  only: [:show, :start]
  before_action :examiner_user, except: [:show, :start]

  # GET /tests
  # GET /tests.json
  def index
    @quizzes = Quiz.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @quiz = Quiz.find(params[:id])
    @invitation = @quiz.invitations.find_by_email(current_user.email)
    if !@invitation.end_time.blank?
      @end_time_converted = Time.parse(@invitation.end_time).localtime
    end
  end

  # GET /tests/new
  def new
    @quiz = Quiz.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to @quiz, flash: { success: 'Quiz was successfully created' }
    else
      render 'new'
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    if @quiz.update(quiz_params)
      redirect_to @quiz, flash: { success: 'Quiz was successfully updated' }
    else
      render 'edit'
    end
  end

  def start
    @quiz = Quiz.find(params[:id])
    @invitation = @quiz.invitations.find_by_email(current_user.email)
    if @invitation.end_time.blank?
      @invitation.update(end_time: (Time.now.localtime + @quiz.time_limit.minutes).to_s)
    end
    @end_time_converted = Time.parse(@invitation.end_time).localtime
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @quiz.destroy
    redirect_to quizzes_url, flash: { success: 'Quiz was successfully deleted' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, :description)
    end

    def invited_user
      @quiz = Quiz.find(params[:id])
      @invitation = @quiz.invitations.find_by_email(current_user.email)
      redirect_to root_url, flash: { danger: "Access denied" } unless !@invitation.blank? || current_user.examiner? || current_user.admin?
    end
end
