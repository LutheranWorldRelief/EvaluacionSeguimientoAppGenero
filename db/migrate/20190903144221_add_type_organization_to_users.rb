class AddTypeOrganizationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :organization_type, :string
  end
end
