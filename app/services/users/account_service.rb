# frozen_string_literal: true

module Users
  # Service to check if user has an account
  class AccountService < ApplicationService
    attr_reader :token

    def initialize(token = nil)
      super()
      @token = token
    end

    def call
      return false if token_blank?(@token)

      account
    end

    private

    def account
      user = User.find_by(token_dg: @token)
      return false unless user

      Auth::TokenProvider.issue_token({ email: user.email, fractal_id: user.fractal_id })
    end
  end
end
