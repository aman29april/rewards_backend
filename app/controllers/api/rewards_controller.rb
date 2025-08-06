class Api::RewardsController < ApplicationController
  before_action :set_current_user

  def index
    rewards = Reward.active.not_redeemed_by(@current_user).order(:cost)
    render json: rewards
  end

  private

  def set_current_user
    @current_user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
end
