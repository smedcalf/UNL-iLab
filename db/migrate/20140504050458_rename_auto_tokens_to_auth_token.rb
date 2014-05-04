class RenameAutoTokensToAuthToken < ActiveRecord::Migration
  def change
    rename_table :auto_tokens, :auth_tokens
  end
end
