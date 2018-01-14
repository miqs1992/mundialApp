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

  def name
    self.first_name + " " + self.last_name
  end
end
