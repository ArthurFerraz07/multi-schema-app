class CarsController < ApplicationController
  around_action :set_db_connection
  # before_action :set_writer_schema
  # before_action :set_search_schema
  # after_action :reset_schema

  def index
    sleep 2
    p '-' * 50
    p '@schema: '
    p @schema
    p 'schema_search_path: '
    p ActiveRecord::Base.connection.schema_search_path
    render json: Car.all.to_json
  end

  def create
    sleep 2
    p '-' * 50
    p '@schema: '
    p @schema
    p 'table_name: '
    p Car.table_name
    car = Car.create!(permitted_params)
    render json: car.to_json
  end

  private

  def set_db_connection
    Thread.new {
      set_writer_schema
      set_search_schema
      yield
      reset_schema
    }.join
  end

  def set_writer_schema
    Car.change_writer_schema(@schema)
  end

  def set_search_schema
    Car.change_search_schema(@schema)
  end

  def reset_schema
    Car.change_writer_schema('public').change_search_schema('public')
  end

  def permitted_params
    params.permit(:model).merge!(writer_schema: @schema)
  end
end
