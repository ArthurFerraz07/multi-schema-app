class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :writer_schema

  def schema_valid?
    if writer_schema.blank? ||
       ActiveRecord::Base.connection.schema_names.exclude?(writer_schema) ||
       writer_schema == 'public'
      errors.add(:base, :invalid)
      throw :abort
    end
    true
  end

  def self.reset_scope_schema
    ActiveRecord::Base.connection.schema_search_path = 'public'
    self.table_name = "public.#{name.pluralize.downcase}"
    self
  end

  def self.change_class_schema(writer_schema = 'public')
    raise 'invalid schema' if writer_schema.blank? || ActiveRecord::Base.connection.schema_names.exclude?(writer_schema)

    dynamic_name = "#{name}#{writer_schema}"
    Object.const_set(dynamic_name, clone) unless class_exists?(dynamic_name)
    klass = dynamic_name.constantize
    klass.table_name = "#{writer_schema}.#{name.pluralize.downcase}"
    klass
  end

  def self.class_exists?(klass_name)
    true if Kernel.const_get(klass_name)
  rescue NameError
    false
  end
end
