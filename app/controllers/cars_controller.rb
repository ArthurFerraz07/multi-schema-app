class CarsController < ApplicationController
  before_action :set_scope
  after_action :reset_schema

  def index
    # sleep 2
    p '-' * 50
    p '@schema: '
    p @schema
    p 'schema_search_path: '
    render json: @scope.all.to_json
  end

  def create
    sleep 2
    p '-' * 50
    p '@schema: '
    p @schema
    p 'table_name: '
    p @scope.table_name
    car = @scope.create!(permitted_params)
    render json: car.to_json
  end

  private

  def set_scope
    @scope = Car.change_class_schema(@schema)
  end

  def reset_schema
    Car.reset_scope_schema
  end

  def permitted_params
    params.permit(:model).merge!(writer_schema: @schema)
  end
end
