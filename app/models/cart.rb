class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  enum status: { active: 0, abandoned: 1, removed: 2 }

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  before_save :update_last_activity, :update_total_price

  # Marca carrinho como abandonado
  def mark_as_abandoned
    update!(status: :abandoned)
  end

  # Marca carrinho como removido
  def mark_as_removed
    update!(status: :removed)
  end

  private

  def update_last_activity
    self.last_activity_at = Time.current
  end

  def update_total_price
    self.total_price = cart_items.sum(:total_price)
  end
end
