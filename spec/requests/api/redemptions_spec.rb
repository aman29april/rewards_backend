require 'rails_helper'

RSpec.describe 'Api::Redemptions', type: :request do
  let!(:user) { User.create!(name: 'Test User', email: 'test@example.com', points_balance: 1000) }
  let!(:reward) { Reward.create!(name: 'Test Reward', description: 'A test reward', cost: 200) }

  describe 'POST /api/redemptions' do
    context 'with sufficient points' do
      it 'redeems the reward and decrements user points' do
        expect {
          post api_redemptions_path, params: { redemption: { user_id: user.id, reward_id: reward.id } }
        }.to change(Redemption, :count).by(1)
        user.reload # Reload user to get updated points_balance
        expect(user.points_balance).to eq(800) # 1000 - 200
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Reward redeemed successfully!')
      end
    end

    context 'with insufficient points' do
      before { user.update!(points_balance: 100) } # Set points lower than reward cost

      it 'does not redeem the reward and returns an error' do
        expect {
          post api_redemptions_path, params: { redemption: { user_id: user.id, reward_id: reward.id } }
        }.not_to change(Redemption, :count)
        user.reload
        expect(user.points_balance).to eq(100) # Points should remain unchanged
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to include('Points balance is insufficient')
      end
    end

    context 'with invalid user or reward ID' do
      it 'returns a not found error for invalid user' do
        post api_redemptions_path, params: { redemption: { user_id: 999, reward_id: reward.id } }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User or Reward not found.')
      end

      it 'returns a not found error for invalid reward' do
        post api_redemptions_path, params: { redemption: { user_id: user.id, reward_id: 999 } }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User or Reward not found.')
      end
    end
  end
end
