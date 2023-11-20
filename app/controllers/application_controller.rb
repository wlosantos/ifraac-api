# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate!

  private

  def authenticate!
    authenticate_or_request_with_http_token do |token, _options|
      payload = Auth::TokenProvider.decode_token(token)
      @current_user = User.find_by(email: payload['email'], fractal_id: payload['fractal_id'])
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  attr_reader :current_user

  def user_not_authorized
    render json: { error: 'No Authorization!' }, status: :unauthorized
  end

  def authorization_header(token)
    response.headers['Authorization'] = "Bearer #{token}"
  end
end
