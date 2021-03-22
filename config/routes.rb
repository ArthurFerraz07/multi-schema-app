class SubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? &&
      request.subdomain != 'www' &&
      ActiveRecord::Base.connection.schema_names.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  constraints SubdomainConstraint do
    get '/cars/index' => 'application#cars_index'
    get '/cars/create' => 'application#create_car'
  end
  mount RailsAdmin::Engine => '/admin/:company_scope/', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
