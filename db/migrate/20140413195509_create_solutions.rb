class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|

      t.string :semester
      t.string :name
      t.text   :csv

      t.timestamps

    end
  end
end
