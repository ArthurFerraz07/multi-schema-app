class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table 'public.companies' do |t|
      t.string :name
      t.string :schema

      t.timestamps
    end
  end
end
