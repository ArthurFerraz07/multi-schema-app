class Company < ApplicationRecord
  validates :name, :schema, presence: true, allow_blank: false, uniqueness: true
  before_create :generate_schema

  def generate_schema
    # binding.pry
    if schema.present? &&
       ActiveRecord::Base.connection.schema_names.exclude?(schema) &&
       schema.to_s.strip.delete('^a-z').downcase == schema

      ActiveRecord::Base.connection.create_schema(schema)
      run_migrations
    else
      throw :abort
    end
  end

  def run_migrations
    classes = []
    Dir["#{Rails.root}/db/migrate/*"].sort.each do |file|
      migration = file.split('/').last.split('_').first
      next if last_migration.present? && migration.to_time <= last_migration.to_time

      self.last_migration = migration
      # binding.pry
      require file
      f = File.open(file).read
      f.each_line do |line|
        next unless line.to_s.include?('ActiveRecord::Migration[6.0]')

        klass = line.to_s.remove('ActiveRecord::Migration[6.0]', '<', 'class').strip.delete('^a-z-A-Z')
        classes.push(klass.constantize) unless klass == 'CreateCompanies'
        break
      end
    end
    # binding.pry
    classes.each { |klass| klass.new.change(schema) }
  end
end
