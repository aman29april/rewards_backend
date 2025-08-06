require 'rails_helper'

RSpec.describe 'Api::Rewards', type: :request do
  describe 'GET /api/rewards' do
    before do
      # Create some rewards for testing
      Reward.create!(name: 'Small Reward', description: 'A small reward', cost: 50)
      Reward.create!(name: 'Big Reward', description: 'A big reward', cost: 500)
    end

    it 'returns a list of all rewards' do
      get api_rewards_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
      expect(JSON.parse(response.body).map { |r| r['name'] }).to include('Small Reward', 'Big Reward')
    end

    it 'returns rewards ordered by cost' do
      get api_rewards_path
      rewards = JSON.parse(response.body)
      expect(rewards.first['cost']).to be <= rewards.last['cost']
    end
  end
end
