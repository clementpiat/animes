class AddCharacterToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :character_cd, :integer, after: :password_digest
  end
end
