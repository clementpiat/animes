class CreatePlaylistsMusics < ActiveRecord::Migration[5.2]
  def change
    create_join_table :playlists, :musics do |t|
      t.index [:playlist_id, :music_id]
    end
  end
end
