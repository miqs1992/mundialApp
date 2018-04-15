# Model drużyny piłkarskiej
class Team < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :flag
  validates_uniqueness_of :name
  validates_uniqueness_of :flag

  has_many :players
  has_many :selected_by, class_name: 'User', foreign_key: 'team_id'

  def print
    "<span class=\"flag-icon flag-icon-#{flag}\"></span> #{name}".html_safe
  end
end
