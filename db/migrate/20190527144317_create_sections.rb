class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :code
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
