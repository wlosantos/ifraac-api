# frozen_string_literal: true

# Base class for all services
class ApplicationService
  include Errors::FailureService

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
