# Model pilkarza
class Player < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :number
  validates_uniqueness_of :number, scope: :team_id
  validates_numericality_of :goals, greater_than_or_equal_to: 0
  validates_numericality_of :assists, greater_than_or_equal_to: 0

  belongs_to :team
  has_many :selected_by, class_name: 'User', foreign_key: 'player_id'

  def name
    first_name + ' ' + last_name
  end

  def self.king
    all.where(king: true).first
  end
end
