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
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:points_balance) }
  it { should validate_numericality_of(:points_balance).is_greater_than_or_equal_to(0) }
  it { should have_many(:redemptions) }

  it 'has a default points_balance of 0 if not set' do
    user = User.create(name: 'Test User', email: 'test@example.com')
    expect(user.points_balance).to eq(0)
  end

  describe '#deduct_points' do
    let(:user) { User.create!(name: 'Points User', email: 'points@example.com', points_balance: 500) }

    context 'when user has sufficient points' do
      it 'deducts the points and saves the user' do
        expect { user.deduct_points(100) }.to change { user.reload.points_balance }.from(500).to(400)
        expect(user.errors).to be_empty
      end

      it 'returns true' do
        expect(user.deduct_points(100)).to be true
      end
    end

    context 'when user has insufficient points' do
      it 'does not deduct points and adds an error' do
        expect { user.deduct_points(600) }.not_to change { user.reload.points_balance }
        expect(user.errors[:points_balance]).to include("is insufficient")
      end

      it 'returns false' do
        expect(user.deduct_points(600)).to be false
      end
    end
  end
end
