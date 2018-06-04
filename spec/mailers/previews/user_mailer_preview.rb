# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # def init_password_email
  #   UserMailer.init_password_email(User.first, "faketoken")
  # end

  def reset_password_email
    Devise::Mailer.reset_password_instructions(User.first, "faketoken")
  end

  def match_day_email
    UserMailer.match_day_email(User.first, MatchDay.first)
  end
    
end
  