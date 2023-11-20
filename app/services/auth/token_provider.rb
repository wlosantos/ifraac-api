# frozen_string_literal: true

module Auth
  # Provider for JWT tokens
  class TokenProvider
    ALGORITHM = 'HS256'

    def self.issue_token(payload)
      JWT.encode(payload, secret_key, ALGORITHM)
    end

    def self.decode_token(token)
      JWT.decode(token, secret_key, true, algorithm: ALGORITHM)[0]
    rescue JWT::DecodeError
      'Invalid Token!'
    end

    def self.valid_payload?(payload)
      payload[:email].present? && payload[:fractal_id].present?
    end

    def self.secret_key
      Rails.application.secrets.secret_key_base.to_s.freeze
    end
  end
end
