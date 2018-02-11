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
            flash[:notice] = "Utworzono nowego użytkownika"
            redirect_to users_path
        else
            flash[:alert] = @user.errors.full_messages.first
            redirect_to new_user_path
        end
    end
    

    private

    def user_params
        params.require(:user).permit(:login, :email, :first_name, :last_name)
    end

    def authorize_admin
        return unless !current_user.admin?
        redirect_to root_path, alert: I18n.t('errors.messages.access_denied') 
    end
end
