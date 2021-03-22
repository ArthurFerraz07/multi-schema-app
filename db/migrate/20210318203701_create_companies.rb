class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :schema
      t.string :last_migration

      t.timestamps
    end
  end
end