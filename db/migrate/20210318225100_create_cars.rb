class CreateCars < ActiveRecord::Migration[6.0]
  def change(schema_name = nil)
    return nil if schema_name.present? && ActiveRecord::Base.connection.schema_names.exclude?(schema_name)

    table_name = schema_name ? "#{schema_name}.cars" : 'cars'
    create_table table_name do |t|
      t.string :model
      t.string :plate

      t.timestamps
    end
  end
end
