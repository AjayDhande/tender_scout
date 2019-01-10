class ApplicationController < ActionController::API
  before_action :authenticate_user!, unless: :public_endpoint?
  around_action :set_current_user
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_current_user
    Current.user = current_user
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    Current.user = nil
  end


  protected
    def user_not_authorized
      render json: nil, status: 403
    end

    def public_endpoint?
      public_endpoints = [
        { controller: 'registration_requests', action: 'create' },
        { controller: 'industries', action: 'index' },
        { controller: 'countries', action: 'index' },
        { controller: 'scrapper', action: 'input'}
      ]
      public_endpoints.map{ |endpoint| endpoint[:controller] == controller_name && endpoint[:action] == action_name }.include?(true)
    end
end
