RailsAdmin.config do |config|
  # binding.pry
  config.parent_controller = '::CustomRailsAdminController'
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard do
      only %i[Company]
    end
    index do
      only %i[Company]
    end
    new do
      only %i[Company]
    end
    export do
      only %i[Company]
    end
    bulk_delete do
      only %i[Company]
    end
    show do
      only %i[Company]
    end
    edit do
      only %i[Company]
    end
    delete do
      only %i[Company]
    end
    show_in_app do
      only %i[Company]
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
