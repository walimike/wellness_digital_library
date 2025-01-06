class AddOrganizationIdAndRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :organization_id, :integer
    add_column :users, :role, :string
  end
end
