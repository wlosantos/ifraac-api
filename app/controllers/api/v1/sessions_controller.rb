# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate!, only: %i[create]
      before_action :token_unpresent, only: %i[create], if: -> { params[:token].blank? || params[:token].nil? }
      before_action :token_params

      def create
        account_token = Users::AccountService.call(params[:token])

        if account_token
          authorization_header(account_token)
          render json: { token: account_token }, status: :ok
        else
          handle_account_dg
        end
      end

      private

      def token_params
        params.permit(:token, :url)
      end

      def token_unpresent
        render json: { error: 'Token is required' }, status: :unauthorized
      end

      def handle_account_dg
        x_token = Users::DgAccountService.new(token: params[:token], url: params[:url]).call

        if x_token.status == 401
          error = JSON.parse(x_token.body, symbolize_names: true)
          logger_message(error[:message])
          render json: { error: error[:message] }, status: :unauthorized
        else
          handle_user_dg(JSON.parse(x_token.body, symbolize_names: true))
        end
      end

      def handle_user_dg(dg_user)
        account = { token: params[:token], name: dg_user[:name],
                    email: dg_user[:email], fractal_id: dg_user[:fractal_id],
                    status: dg_user[:action], photo_url: dg_user[:photo_url],
                    units: dg_user[:units] }

        account_token = Users::LoginService.new(token: params[:token], dg_user: account).call

        if account_token
          authorization_header(account_token)
          render json: { token: account_token }, status: :ok
        else
          render json: { token: 'Invalid token' }, status: :unauthorized
        end
      end

      def authorization_header(token)
        response.headers['Authorization'] = "Bearer #{token}"
      end

      def logger_message(message)
        logger.error "[#{Time.now}] - #{message}"
      end
    end
  end
end
