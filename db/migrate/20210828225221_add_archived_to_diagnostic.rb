class AddArchivedToDiagnostic < ActiveRecord::Migration[5.2]
  def up
    add_column :diagnostics, :archived, :boolean
    add_column :diagnostics, :archived_date, :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
  end

  def down
    remove_column :diagnostics, :archived
    remove_column :diagnostics, :archived_date
  end
end
