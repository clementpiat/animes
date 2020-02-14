class CreatePlaylistsAnimes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :playlists, :animes do |t|
      t.index [:playlist_id, :anime_id]
    end
  end
end
