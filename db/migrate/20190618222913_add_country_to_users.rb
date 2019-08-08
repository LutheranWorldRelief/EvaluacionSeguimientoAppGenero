class AddCountryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :country, :string
    add_column :users, :country_zipcode, :string
  end
end
