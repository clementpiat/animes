class Playlist < ApplicationRecord
    has_and_belongs_to_many :musics
    has_and_belongs_to_many :animes
    belongs_to :user
end
