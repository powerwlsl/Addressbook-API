class AddOrganizationIdsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :organization_ids, :array
  end
end
