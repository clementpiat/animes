class AddAlternativeNamesToAnimes < ActiveRecord::Migration[5.2]
  def change
    add_column :animes, :alternative_names, :text, after: :rank
  end
end
