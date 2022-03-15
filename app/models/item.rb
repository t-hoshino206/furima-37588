class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecrure
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :shipping_schedule

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :user
  has_one_attached :image
end
