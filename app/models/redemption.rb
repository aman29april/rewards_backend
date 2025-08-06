# == Schema Information
#
# Table name: redemptions
#
#  id           :integer          not null, primary key
#  points_spent :integer
#  redeemed_at  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  reward_id    :integer          not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_redemptions_on_reward_id  (reward_id)
#  index_redemptions_on_user_id    (user_id)
#
# Foreign Keys
#
#  reward_id  (reward_id => rewards.id)
#  user_id    (user_id => users.id)
#
class Redemption < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  validates :points_spent, presence: true, numericality: { greater_than: 0 }
  validates :redeemed_at, presence: true
end
