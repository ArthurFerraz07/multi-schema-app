class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def schema_valid?
    current_schema = self.class.table_name.split('.').first
    if current_schema.blank? || current_schema == self.class.table_name || Rails.application.database_schemas.exclude?(current_schema)
      errors.add(:base, :invalid)
      throw :abort
    end
    true
  end

  def self.change_schema(schema = '')
    return nil if schema.present? && Rails.application.database_schemas.exclude?(schema)

    klass = clone
    klass.table_name = schema.present? ? "#{schema}.cars" : 'cars'
    klass
  end
end
