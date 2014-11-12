class InvitationsController < ApplicationController
  before_action :logged_in_user
  before_action :invited_user,  only: [:edit, :update]
  before_action :examiner_user, except: [:edit, :update]

  def index
    @invitations = Invitation.all
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def new
    @quiz = Quiz.find(params[:quiz_id])
    @invitation = Invitation.new
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @invitation = @quiz.invitations.new(invitation_params)
    @invitation.sender_name = current_user.name
    if @invitation.save
      @email = @invitation.email
      if (User.exists?(email: @email))
        @user = User.find_by(email: @email)
        UserMailer.quiz_invitation(@invitation.sender_name, @user, @quiz, false).deliver
      else
        @password = generate_random_password
        @user = User.new(name: get_name_from_email(@email), email: @email, password: @password, password_confirmation: @password)
          if @user.save
            UserMailer.quiz_invitation(@invitation.sender_name, @user, @quiz, true).deliver
          else
            render 'new'
          end
      end
      redirect_to @invitation.quiz, flash: { success: 'Invitation was successfully sent to ' + @email }
    else
      render 'new'
    end
  end

  def update
    @invitation = Invitation.find(params[:id])
    @end_time_converted = Time.parse(@invitation.end_time)
    if @end_time_converted <= Time.now
      redirect_to quiz_path(@invitation.quiz), flash: { danger: "Quiz is over" }
    elsif params[:invitation]
      if @invitation.update(invitation_params)
        redirect_to start_quiz_path(@invitation.quiz), flash: { success: 'Attachment was successfully uploaded' }
      else
        redirect_to :back, flash: { danger: 'Attachment failed to upload' }
      end
    else
      redirect_to start_quiz_path(@invitation.quiz), flash: { danger: 'Attachment cannot be empty' }
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to @invitation.quiz, flash: { success: 'Invitation was successfully deleted' }
  end

  private
    def invitation_params
      params.require(:invitation).permit(:email, :quiz_answer)
    end

    def get_name_from_email(email)
      name = email.partition('@')[0]
    end

    def generate_random_password
      random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    end

    def invited_user
      @invitation = Invitation.find(params[:id])
      redirect_to root_url, flash: { danger: "Access denied" } unless @invitation.email == current_user.email || current_user.examiner? || current_user.admin?
    end
end
