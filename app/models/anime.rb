class Anime < ApplicationRecord
    has_many :musics
    has_and_belongs_to_many :playlists

    paginates_per 50

    serialize :alternative_names, Array
end
