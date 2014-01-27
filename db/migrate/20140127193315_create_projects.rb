class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.integer :initial_capacity
      t.references :sponsors, polymorphic: true, index: true
      t.integer :current_capacity
      t.string :semester
      t.string :file_path
      t.string :file_name
      t.boolean :active
      t.boolean :status

      t.timestamps
    end
  end
end
