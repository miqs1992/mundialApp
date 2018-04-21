class UserLeague < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates_uniqueness_of :user_id, scope: :league_id
end
