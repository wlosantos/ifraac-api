module Api
  # Service to connect to the API
  class AuthService < ApplicationService
    attr_reader :conn, :token, :url

    def initialize(token:, url:)
      super()
      @token = token
      @url = url
      @conn = Api::ConnectService.new(token: @token, url: @url).call
    end

    def call
      connect
    end

    private

    def connect
      return params_error(@token, @url) unless conn?

      @conn.post do |req|
        req.url 'api/v1/users/check'
      end
    end

    def conn?
      @token.present? && @url.present?
    end
  end
end
