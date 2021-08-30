class AddArchivedToDiagnostic < ActiveRecord::Migration[5.2]
  def up
    add_column :diagnostics, :archived_date, :timestamp, null: true
    add_column :diagnostics, :archived_user_id, :integer, null: true
  end

  def down
    remove_column :diagnostics, :archived_date
    remove_column :diagnostics, :archived_user_id
  end
end
