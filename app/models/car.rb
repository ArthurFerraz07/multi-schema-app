class Car < ApplicationRecord
  def self.change_schema(schema = '')
    return nil if Rails.application.database_schemas.exclude?(schema)

    klass = clone
    klass.table_name = "#{schema}.cars"
    klass
  end
end
