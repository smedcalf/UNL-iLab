class CreateStudentPreferences < ActiveRecord::Migration
  def change
    create_table :student_preferences do |t|
    	t.belongs_to 	:student
    	t.belongs_to 	:project
    	t.integer			:rating
    	
      t.timestamps
    end
  end
end
