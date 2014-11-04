class InvitationsController < ApplicationController
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
    if @invitation.save
      redirect_to @invitation.quiz, flash: { success: 'Invited' }
    else
      render :new
    end
  end

  def update
    if @invitation.update(invitation_params)
      redirect_to @invitation.quiz, flash: { success: 'Invitation was successfully updated' }
    else
      render :edit
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
end
