class ApplicationController < ActionController::Base
  before_action :check_subdomain
  before_action :set_schema

  private

  def set_schema
    @schema = request.subdomain
  end

  def check_subdomain
    raise StandardError, 'Invalid subdomain' if request.subdomain.blank? || ENV.fetch('SUBDOMAINS', '').split(', ').exclude?(request.subdomain)
  end
end
