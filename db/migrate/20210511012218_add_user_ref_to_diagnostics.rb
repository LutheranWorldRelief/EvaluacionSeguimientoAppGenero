class AddUserRefToDiagnostics < ActiveRecord::Migration[5.2]
  def change
    add_reference :diagnostics, :user, foreign_key: true
  end
end
