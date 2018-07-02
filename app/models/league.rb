class League < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :user_leagues, dependent: :destroy
  has_many :users, -> { order(points: :desc) }, through: :user_leagues

  def place(user, array = self.users.exact_bets)
    begin
      user_exact_bets = array.detect{|u| u.id == user.id}.bets_count
      result = array.select{|u| u.points > user.points}.length
      result += array.select{|u| u.points == user.points}.select{|u| u.bets_count > user_exact_bets}.length
      result += 1
    rescue
      0
    end
  end

  def get_ordered_users
    array = self.users.exact_bets
    array.map{|user| user.as_json.merge("place" => place(user, array))}.sort_by{|u| u["place"]}
  end
end
