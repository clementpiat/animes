class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|
      t.string :name

      t.timestamps
    end

    add_index :animes, :name
  end
end
