class User < ApplicationRecord
  validates :name, :email, :fractal_id, :token_dg, presence: true
  validates :email, :fractal_id, :token_dg, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_enumeration_for :status, with: Status, create_helpers: true
end
