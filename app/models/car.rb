class Car < ApplicationRecord
  validate :schema_valid?

  scope :teste, -> { find_by_sql(Rails.application.database_schemas.map { |schema_name| "SELECT '#{schema_name}' AS schema, cars.* FROM #{schema_name}.cars" }.join(' UNION ')) }
end
