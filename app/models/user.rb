class User < ApplicationRecord
    has_many :reservations, dependent: :destroy
    has_many :products, through: :reservations, dependent: :destroy

    validates :name, presence: true
end
