class CreateMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :musics do |t|
      t.string :name
      t.text :youtube_url
      t.belongs_to :anime

      t.timestamps
    end
  end
end
