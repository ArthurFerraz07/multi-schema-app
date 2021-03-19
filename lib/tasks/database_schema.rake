# frozen_string_literal: true

namespace :database_schema do
  desc 'Testando criação de um db schema.'
  task :create, [:schema_name] => :environment do |task, args|
    if args[:schema_name].present? &&
       Rails.application.database_schemas.exclude?(args[:schema_name]) &&
       args[:schema_name].to_s.strip.delete('^a-z') == args[:schema_name]

      sql = "CREATE SCHEMA #{args[:schema_name]}"
      ActiveRecord::Base.connection.execute(sql)
      p 'deu certo'
    else
      p 'deu ruim'
    end
  rescue StandardError => e
    print e
  end
end
