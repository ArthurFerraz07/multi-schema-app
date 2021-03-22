class ApplicationController < ActionController::Base
  before_action :set_schema
  before_action :set_search_schema
  after_action :reset_schema

  def cars_index
    p '-' * 50
    p 'schema: '
    sleep(3) if @schema == 'jorast'
    p ActiveRecord::Base.connection.schema_search_path
    render json: Car.all.to_json
  end

  def create_car
    p '-' * 50
    p 'table_name: '
    p Car.table_name
    # sleep(5)
    car = Car.change_writer_schema(@schema).create!(permitted_params)
    render json: car.to_json
  end

  private

  def set_schema
    @schema = request.subdomain
  end

  def set_search_schema
    Car.change_search_schema(@schema)
  end

  def reset_schema
    Car.change_writer_schema('public')
    Car.change_search_schema('public')
  end

  def permitted_params
    params.permit(:model).merge!(writer_schema: @schema)
  end
end
