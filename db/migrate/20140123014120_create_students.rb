class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string			:email
    	t.string			:first_name
    	t.string			:last_name
    	t.string			:major
    	t.string			:semester
    	t.string			:classname
    	t.integer			:availability
    	t.integer			:status

      t.timestamps
    end
  end
end
