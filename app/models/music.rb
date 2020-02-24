class Music < ApplicationRecord
    has_and_belongs_to_many :playlists
    belongs_to :anime

    as_enum :type, {ost: 0, opening: 1}
end
