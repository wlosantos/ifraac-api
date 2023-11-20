# frozen_string_literal: true

module Users
  class DgAccountService < ApplicationService
    attr_reader :token, :url

    def initialize(token:, url:)
      super()
      @token = token
      @url = url
    end

    def call
      return false if token_blank?(@token) || url_blank?(@url)

      dg_account
    end

    private

    def dg_account
      Api::AuthService.new(token: @token, url: @url).call
    end
  end
end
