# frozen_string_literal: true

namespace :database_schema do
  task run_migrations: :environment do
    Company.all.each(&:run_migrations)
  end
end
