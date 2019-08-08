class RemoveCountryZipcodeFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :country_zipcode, :string
  end
end
