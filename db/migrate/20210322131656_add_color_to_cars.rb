class AddColorToCars < ActiveRecord::Migration[6.0]
  def change(schema_name = nil)
    return nil if schema_name.present? && ActiveRecord::Base.connection.schema_names.exclude?(schema_name)

    table_name = schema_name ? "#{schema_name}.cars" : 'cars'
    add_column table_name, :color, :string
  end
end
