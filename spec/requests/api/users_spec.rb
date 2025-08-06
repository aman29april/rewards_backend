require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  include FactoryBot::Syntax::Methods

  let!(:user) { create(:user, points_balance: 500) }
  let!(:reward) { create(:reward, name: 'Test Reward', description: 'A test reward', cost: 100) }
  let!(:redemption) { create(:redemption, user: user, reward: reward, points_spent: reward.cost, redeemed_at: DateTime.now) }

  describe 'GET /api/users/:id/points' do
    context 'with a valid user ID' do
      it 'returns the user\'s points balance' do
        get points_api_user_path(user)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['points_balance']).to eq(500)
      end
    end

    context 'with an invalid user ID' do
      it 'returns a not found error' do
        get points_api_user_path(999)
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User not found')
      end
    end
  end

  describe 'GET /api/users/:id/redemptions' do
    context 'with a valid user ID' do
      it 'returns the user\'s redemption history' do
        get redemptions_api_user_path(user)
        expect(response).to have_http_status(:ok)
        redemptions = JSON.parse(response.body)
        expect(redemptions.size).to eq(1)
        expect(redemptions.first['reward']['name']).to eq(reward.name)
      end
    end

    context 'with an invalid user ID' do
      it 'returns a not found error' do
        get redemptions_api_user_path(999)
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('User not found')
      end
    end
  end
end
