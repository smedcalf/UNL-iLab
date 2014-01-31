class CreateProjectsTable < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.integer :initial_capacity
      t.references :sponsor, polymorphic: true, index: true
      t.integer :current_capacity
      t.string :semester
      t.string :proposal_file_name
      t.string :proposal_content_type
      t.integer :proposal_file_size
      t.boolean :active
      t.boolean :status

      t.timestamps
    end
  end
end
