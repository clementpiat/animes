class Music < ApplicationRecord
    has_and_belongs_to_many :playlists
    belongs_to :anime

    as_enum :type, {ost: 0, opening: 1, custom: 2}

    # Commented out when we added custom music
    # TODO: uniqueness by couple name/anime
    validates :name, uniqueness: true

    def youtube_video_url
        "https://www.youtube.com/watch?v=#{youtube_video_id}"
    end

    # Parse a youtube url
    # TODO: safer?
    def self.url_to_id(youtube_video_url)
        if youtube_video_url.present? && 'watch?v='.in?(youtube_video_url)
            youtube_video_url.split('watch?v=').last.split('&').first
        else
            nil
        end
    end
end
