class CreateInstructorTerms < ActiveRecord::Migration
  def change
    create_table :instructor_terms do |t|
      t.references :instructor, index: true
      t.string :semester

      t.timestamps
    end
  end
end
