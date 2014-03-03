class AddCompletedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :completed, :boolean, default: false, null: false
  end
end
