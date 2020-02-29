class AddUserIdToPlaylist < ActiveRecord::Migration[5.2]
  def change
    add_reference :playlists, :user, index: true
    add_foreign_key :playlists, :users
  end
end
