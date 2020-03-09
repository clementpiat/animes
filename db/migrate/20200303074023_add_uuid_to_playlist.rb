class AddUuidToPlaylist < ActiveRecord::Migration[5.2]
  def change
    # drop_table :playlists

    # create_table :playlists, id: false, force: true do |t|
    #   t.string :id, limit: 36, primary_key: true
    #   t.string :name

    #   t.timestamps
    # end

    # add_reference :playlists, :user, index: true
    # add_foreign_key :playlists, :users
  end
end
