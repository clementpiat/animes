class AddRankAndFilenameToAnime < ActiveRecord::Migration[5.2]
  def change
    add_column :animes, :rank, :integer, after: :name
    add_column :animes, :image_file_name, :string, after: :name
  end
end
