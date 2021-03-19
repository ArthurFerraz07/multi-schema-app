class Company < ApplicationRecord
  validates :name, :schema, presence: true, allow_blank: false, uniqueness: true
  before_create :generate_schema

  def generate_schema
    binding.pry
    if schema.present? &&
      Rails.application.database_schemas.exclude?(schema) &&
      schema.to_s.strip.delete('^a-z').downcase == schema

      sql = "CREATE SCHEMA #{schema}"
      ActiveRecord::Base.connection.execute(sql)
      run_migrations
    else
      throw :abort
    end
  end

  def run_migrations
    classes = []
    Dir["#{Rails.root}/db/migrate/*"].sort.each do |file|
      require file
      f = File.open(file).read
      f.each_line do |line|
        next unless line.to_s.include?('ActiveRecord::Migration[6.0]')

        klass = line.to_s.remove('ActiveRecord::Migration[6.0]', '<', 'class').strip.delete('^a-z-A-Z')
        classes.push(klass.constantize) unless klass == 'CreateCompanies'
        break
      end
    end
    binding.pry
    classes.each { |klass| klass.new.change(schema) }
  end
end
