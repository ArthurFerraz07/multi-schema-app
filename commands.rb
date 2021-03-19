def execute_sql(sql)
  ActiveRecord::Base.connection.execute(sql).values.flatten
  # ActiveRecord::Base.connection.execute(sql)
end
