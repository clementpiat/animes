class AddImageAttributeToMusics < ActiveRecord::Migration[5.2]
  def change
    remove_column :musics, :youtube_url, :text
    add_column :musics, :youtube_video_id, :string, after: :name
    add_column :musics, :type_cd, :integer, after: :name
  end
end
