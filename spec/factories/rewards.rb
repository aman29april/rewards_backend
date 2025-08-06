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
FactoryBot.define do
  factory :reward do
    sequence(:name) { |n| "Test Reward #{n}" }
    description { "A fantastic test reward." }
    cost { 200 }
  end
end
