class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum :status, { pending: 0, paid: 1, failed: 2, canceled: 3 }, default: 0

  def total_amount
    order_items.sum { |item| item.unit_price * item.quantity }
  end

  def expired?
    expires_at.present? && expires_at <= Time.current
  end

  def payment_subject
    "Compra de #{order_items.count} productos"
  end
end
