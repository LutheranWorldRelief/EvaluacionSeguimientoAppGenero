class CreateDiagnostics < ActiveRecord::Migration[5.2]
  def change
    create_table :diagnostics do |t|
      t.string :user_email
      t.integer :counter

      t.timestamps
    end
  end
end
