class RemoveOrganizationIdsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :organization_ids, :string
  end
end
