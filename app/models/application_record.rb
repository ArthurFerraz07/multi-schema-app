class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :writer_schema

  def schema_valid?
    if writer_schema.blank? || ActiveRecord::Base.connection.schema_names.exclude?(writer_schema)
      errors.add(:base, :invalid)
      throw :abort
    end
    true
  end

  def self.change_search_schema(search_schema = 'public')
    raise 'invalid schema' if search_schema.blank? || ActiveRecord::Base.connection.schema_names.exclude?(search_schema)

    ActiveRecord::Base.connection.schema_search_path = search_schema
    self
  end

  def self.change_writer_schema(writer_schema = 'public')
    raise 'invalid schema' if writer_schema.blank? || ActiveRecord::Base.connection.schema_names.exclude?(writer_schema)

    self.table_name = writer_schema == 'public' ? name.pluralize.downcase : "#{writer_schema}.#{name.pluralize.downcase}"
    self
  end
end
