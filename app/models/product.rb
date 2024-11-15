require "image_processing/mini_magick"

class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  def resized_image(width, height)
    image.variant(resize_to_limit: [ width, height ]).processed
  end

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
