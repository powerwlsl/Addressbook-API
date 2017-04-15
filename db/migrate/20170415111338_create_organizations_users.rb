class CreateOrganizationsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations_users do |t|
      t.references :organization, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
