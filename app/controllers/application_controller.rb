class ApplicationController < ActionController::Base
  before_action :set_schema

  private

  def set_schema
    @schema = request.subdomain
  end
end
