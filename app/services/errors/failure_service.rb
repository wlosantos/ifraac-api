module Errors
  # Service to handle errors
  module FailureService
    def params_error(token, url)
      message = {
        default: 'Invalid params',
        token: 'token can\'t be blank',
        url: 'url can\'t be blank'
      }

      return message[:default] if token_blank?(token) && url_blank?(url)

      return message[:token] if token_blank?(token) && !url_blank?(url)

      message[:url]
    end

    def unit_error(unit)
      message = {
        default: 'Invalid unit',
        unit: 'unit can\'t be blank'
      }

      return message[:unit] if unit.blank?

      message[:default]
    end

    def url_blank?(url)
      url.nil? || url.blank?
    end

    def token_blank?(token)
      token.nil? || token.blank?
    end
  end
end
