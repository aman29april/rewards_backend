# == Schema Information
#
# Table name: rewards
#
#  id                :integer          not null, primary key
#  available_from    :datetime
#  available_until   :datetime
#  cost              :integer          not null
#  description       :text
#  enabled           :boolean          default(TRUE)
#  limit             :integer
#  name              :string           not null
#  redemptions_count :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_rewards_on_available_from     (available_from)
#  index_rewards_on_available_until    (available_until)
#  index_rewards_on_enabled            (enabled)
#  index_rewards_on_redemptions_count  (redemptions_count)
#
class Reward < ApplicationRecord
    has_many :redemptions, dependent: :destroy
    has_many :redemptions, dependent: :destroy, counter_cache: true

    validates :name, :cost, presence: true
    validates :cost, numericality: { greater_than: 0 }
    validates :limit, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validate :available_until_after_available_from
    validate :available_until_in_future, on: :create

    scope :enabled, -> { where(enabled: true) }
    scope :unlimited, -> { where(limit: nil) }

    scope :available, -> { where("available_from IS NULL OR available_from <= ?", Time.current).where("available_until IS NULL OR available_until > ?", Time.current) }
    scope :active, -> { enabled.available }
    scope :not_redeemed_by, ->(user) { where.not(id: user.redemptions.select(:reward_id)) }

    def available_until_after_available_from
        return if available_from.nil? || available_until.nil?

        if available_until <= available_from
            errors.add(:available_until, "must be after available_from")
        end
    end

    def available_from_in_future
        return if available_from.nil?

        if available_from < Time.current
            errors.add(:available_from, "must be in the future")
        end
    end

    def available_until_in_future
        return if available_until.nil?

        if available_until < Time.current
            errors.add(:available_until, "must be in the future")
        end
    end

    def expired?
        available_until.present? && Time.current > available_until
    end

    def redeemable_by?(user)
        return false unless available?
        return false if user.points_balance < cost  # Check if user has enough points
        return false if limited? && redemptions.count >= limit  # Check if limit is reached
        true
    end

    def available?
        return false if available_from && Time.current < available_from
        return false if expired?
        return false if limited? && redemptions.count >= limit

        true
    end

    def limited?
        limit.present?
    end
end
