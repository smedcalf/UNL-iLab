class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to 	:student
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :approved
      t.boolean :active

      t.timestamps
    end
  end
end
