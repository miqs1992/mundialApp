class UserMailer < ApplicationMailer
    def init_password_email(user, token)
        @user = user
        @token = token
        mail(to: @user.email, subject: 'Nowe konto w Mundial App')
    end    
end
