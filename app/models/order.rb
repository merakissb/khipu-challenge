class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum :status, { pending: 0, paid: 1, failed: 2 }, default: 0
end
