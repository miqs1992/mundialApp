class Player < ApplicationRecord
    validates_presence_of :first_name
    validates_presence_of :last_name

    belongs_to :team
end
