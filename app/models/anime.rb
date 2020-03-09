class Anime < ApplicationRecord
    has_many :musics
    has_and_belongs_to_many :playlists

    paginates_per 50

    serialize :alternative_names, Array

    validates :name, uniqueness: true

    scope :not_other, -> { where.not(name: 'Other') }

    def self.other
        Anime.where(name: 'Other').first
    end
end
