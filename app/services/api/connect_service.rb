module Api
  # Service to connect to the API
  class ConnectService < ApplicationService
    attr_reader :token, :url

    def initialize(token:, url:)
      super()
      @token = token
      @url = url
    end

    def call
      return params_error(@token, @url) unless connect?

      conn
    end

    private

    def conn
      Faraday.new(
        url: @url,
        headers: {
          'Content-Type' => 'application/json',
          'X-Token' => @token
        }
      )
    end

    def connect?
      @token.present? && @url.present?
    end
  end
end
