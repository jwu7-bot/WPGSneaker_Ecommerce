require "image_processing/mini_magick"

class Product < ApplicationRecord
  belongs_to :category

  has_many :orders
  has_many :carts, through: :orders

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
