class AddRemeberTokensToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remember_tokens, :string
  end
end
