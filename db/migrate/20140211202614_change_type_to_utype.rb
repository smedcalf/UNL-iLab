class ChangeTypeToUtype < ActiveRecord::Migration
  def change
  	rename_column :users, :type, :utype
  end
end
