class Car < ApplicationRecord
  validates :model, presence: true, allow_blank: false
  validate :schema_valid?

  scope :teste, -> { find_by_sql(ActiveRecord::Base.connection.schema_names.map { |schema_name| "SELECT '#{schema_name}' AS schema, cars.* FROM #{schema_name}.cars" }.join(' UNION ')) }
end
