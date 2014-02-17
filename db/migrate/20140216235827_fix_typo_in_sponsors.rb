class FixTypoInSponsors < ActiveRecord::Migration
  def change
  	rename_column :sponsors, :orgnization, :organization
  end
end
