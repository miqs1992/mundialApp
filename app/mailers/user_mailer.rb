class UserMailer < ApplicationMailer
  def init_password_email(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: 'Nowe konto w Mundial App')
  end    

  def match_day_email(user, match_day)
    @user = user
    @match_day = match_day
    mail(to: @user.email, subject: "Zakończono dzień meczowy nr #{@match_day.day_number}")
  end
end
