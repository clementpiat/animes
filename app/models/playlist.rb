class Playlist < ApplicationRecord
    has_and_belongs_to_many :musics
    belongs_to :user
end
