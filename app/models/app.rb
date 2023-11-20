class App < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, :dg_app_id, presence: true
  validates :dg_app_id, uniqueness: true
end
