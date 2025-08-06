# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  email          :string           not null
#  name           :string           not null
#  points_balance :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :redemptions, dependent: :destroy
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, length: { maximum: 100 }, presence: true
  validates :points_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  after_initialize :set_default_points_balance

  def set_default_points_balance
    self.points_balance ||= 0
  end

  def deduct_points(amount)
    with_lock do
      if points_balance >= amount
        self.points_balance -= amount
        save! # Save the changes to the database
        true
      else
        errors.add(:points_balance, "is insufficient. You have #{points_balance} points, but need #{amount} points to redeem this reward.")
        false
      end
    end
  end
end
