# Model pilkarza
class Player < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  belongs_to :team
  has_many :selected_by, class_name: 'User', foreign_key: 'player_id'

  def name
    first_name + ' ' + last_name
  end
end
