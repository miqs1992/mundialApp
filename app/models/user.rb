class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :login
  validates_uniqueness_of :login
  validates_uniqueness_of :email

  has_many :bets

  attr_accessor :devise_login

  def name
    self.first_name + " " + self.last_name
  end

  def points
    self.bets.pluck(:points).inject(0, :+)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if devise_login = conditions.delete(:devise_login)
      where(conditions.to_hash).where(['lower(login) = :value OR lower(email) = :value', {:value => devise_login.downcase }]).first
    elsif conditions.has_key?(:login) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_new_account_message
    raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
    self.reset_password_token = hashed_token
    self.reset_password_sent_at = Time.current
    self.save!
    UserMailer.init_password_email(self, raw_token).deliver_later
  end


end
