class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :first_name
      t.string :last_name
      t.string :orgnization
      t.string :email
      t.string :type

      t.timestamps
    end
    add_index :sponsors, :email, unique: true
  end
end
