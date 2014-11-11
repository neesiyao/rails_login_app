class InvitationsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :examiner_user

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
    if @invitation.update(invitation_params)
      redirect_to @invitation.quiz, flash: { success: 'Invitation was successfully updated' }
    else
      render 'edit'
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to @invitation.quiz, flash: { success: 'Invitation was successfully deleted' }
  end

  private
    def invitation_params
      params.require(:invitation).permit(:email)
    end

    def get_name_from_email(email)
      name = email.partition('@')[0]
    end

    def generate_random_password
      random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    end
end
