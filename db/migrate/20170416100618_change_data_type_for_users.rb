class ChangeDataTypeForUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :organization_ids, :string

  end
end
