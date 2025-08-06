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
require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cost) }
  it { should validate_numericality_of(:cost).is_greater_than(0) }
  it { should have_many(:redemptions) }
end
