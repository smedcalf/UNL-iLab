class CreateInstructorsAndProjects < ActiveRecord::Migration
  def change
    create_table :instructors_projects, id: false do |t|
      t.belongs_to :instructor
      t.belongs_to :project
    end
  end
end