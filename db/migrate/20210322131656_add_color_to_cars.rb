class AddColorToCars < ActiveRecord::Migration[6.0]
  def change(schema_name = nil)
    return nil if schema_name.present? && Rails.application.database_schemas.exclude?(schema_name)

    table_name = schema_name ? "#{schema_name}.cars" : 'cars'
    add_column table_name, :color, :string
  end
end
