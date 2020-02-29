class Music < ApplicationRecord
    has_and_belongs_to_many :playlists
    belongs_to :anime

    as_enum :type, {ost: 0, opening: 1, custom: 2}

    validates :name, uniqueness: true

    def youtube_video_url
        "https://www.youtube.com/watch?v=#{youtube_video_id}"
    end

    # Parse a youtube url
    # TODO: safer?
    def self.url_to_id(youtube_video_url)
        youtube_video_url.split('watch?v=')[1]
    end
end
