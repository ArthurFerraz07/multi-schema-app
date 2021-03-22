class CustomRailsAdminController < ActionController::Base
  before_action :set_global_params

  def set_global_params
    @params = params.permit!
    @params
  end
end
