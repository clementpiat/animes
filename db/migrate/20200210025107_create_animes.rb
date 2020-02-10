class CreateAnimes < ActiveRecord::Migration[5.2]
  def change
    create_table :animes do |t|

      t.timestamps
    end
  end
end
