class Playlist < ApplicationRecord
    has_and_belongs_to_many :musics
    has_and_belongs_to_many :animes
    belongs_to :user

    def musics_for_anime(anime, custom: false)
        musics = self.musics.joins(:anime).where(animes: {id: anime.id})

        if custom
            musics.where(type_cd: Music.types[:custom])
        else
            musics.where.not(type_cd: Music.types[:custom])
        end
    end
end
