class AddEmailConfirmColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirmed, :boolean, after: :character_cd
    add_column :users, :confirm_token, :string, after: :character_cd
  end
end
