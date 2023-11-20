# frozen_string_literal: true

# access to the version of the API
class ApiVersionConstraint
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.ifraac.v#{@version}")
  end
end
