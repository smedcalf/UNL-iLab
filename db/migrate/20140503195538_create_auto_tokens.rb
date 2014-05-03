class CreateAutoTokens < ActiveRecord::Migration
  def change
    create_table :auto_tokens do |t|
      t.text :token

      t.timestamps
    end
  end
end
