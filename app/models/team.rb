class Team < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :flag
    validates_uniqueness_of :name
    validates_uniqueness_of :flag

    has_many :players

    def print
        "<span class=\"flag-icon flag-icon-#{self.flag}\"></span> #{self.name}".html_safe
    end
end
