class UsersController < ApplicationController
  before_action :authorize_admin

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.password = SecureRandom.hex
    if @user.save
      @user.send_new_account_message
      flash[:notice] = 'Utworzono nowego użytkownika'
      redirect_to users_path
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if before_first_game? && @user.update_attributes(top_team_and_player_params)
      flash[:notice] = 'Zapisano zmiany'
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.first
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :email, :first_name, :last_name)
  end

  def top_team_and_player_params
    params.require(:user).permit(:team_id, :player_id)
  end
end
