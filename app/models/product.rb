class Product < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations, dependent: :destroy

  validates :name, :image, :description, :model, :engine, presence: true
  validates :price, :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
