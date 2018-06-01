# Model uzytkownika
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
  validates_numericality_of :points, greater_than_or_equal_to: 0

  belongs_to :top_team, class_name: 'Team', foreign_key: 'team_id', optional: true
  belongs_to :top_player, class_name: 'Player', foreign_key: 'player_id', optional: true

  has_many :bets
  has_many :user_leagues, dependent: :destroy
  has_many :leagues, through: :user_leagues

  after_create :add_to_main_leagues

  attr_accessor :devise_login

  def name
    first_name + ' ' + last_name
  end

  def calculate_points(king, winner)
    points = bets.pluck(:points).inject(0, :+)
    
    if picked_tops? && top_player == king
      points += 5
    end

    if picked_tops? && top_team == winner
      points += 7
    end

    self.update(points: points)
  end

  def self.recalculate
    king = Player.king
    winner = Team.winner
    all.each do |u|
      u.calculate_points(king, winner)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (devise_login = conditions.delete(:devise_login))
      where(conditions.to_hash).where(['lower(login) = :value OR lower(email) = :value', {:value => devise_login.downcase }]).first
    elsif conditions.key?(:login) || conditions.key?(:email)
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
    save!
    UserMailer.init_password_email(self, raw_token).deliver_later
  end

  def picked_tops?
    !(player_id.nil? || team_id.nil?)
  end

  def add_to_main_leagues
    League.where(main: true).each do |league|
      self.leagues << league
    end
  end
end
