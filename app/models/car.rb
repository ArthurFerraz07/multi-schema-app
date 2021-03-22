class Car < ApplicationRecord
  validate :schema_valid?
end
