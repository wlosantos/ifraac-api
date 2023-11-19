# frozen_string_literal: true

module Users
  class LoginService < ApplicationService
    attr_reader :token, :dg_user

    def initialize(token: nil, dg_user: nil)
      super()
      @token = token
      @dg_user = dg_user
    end

    def call
      return false unless @token.present? || @dg_user.present?

      account
    end

    private

    def account # rubocop:disable Metrics/AbcSize
      account = User.find_by(email: @dg_user[:email], fractal_id: @dg_user[:fractal_id])

      if account.present? && account.update(token_dg: @token)
        Auth::TokenProvider.issue_token({ email: account.email, fractal_id: account.fractal_id })
      else
        unit = user_unit(@dg_user[:units])
        return unit_error(unit) unless unit.present?

        user = User.create(name: @dg_user[:name], email: @dg_user[:email],
                           fractal_id: @dg_user[:fractal_id],
                           token_dg: @token, photo_url: @dg_user[:photo_url],
                           unit_dg: unit.unit_dg)

        Auth::TokenProvider.issue_token({ email: user.email, fractal_id: user.fractal_id })
      end
    end

    def user_unit(units)
      return unless units.present?

      unit_first = units.first
      unit = Unit.find_by(unit_dg: unit_first[:id])
      return unit if unit.present?

      Unit.create!(unit_dg: unit[:id], name: unit[:name])
    end
  end
end
