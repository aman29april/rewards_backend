class Api::RedemptionsController < ApplicationController
  def create
    reward = Reward.find(redemption_params[:reward_id])
    user = User.find(redemption_params[:user_id])

    Redemption.transaction do
        if user.deduct_points(reward.cost)
            redemption = Redemption.create!(
              user: user,
              reward: reward,
              redeemed_at: DateTime.now,
              points_spent: reward.cost
            )
            render json: {
              message: "Reward redeemed successfully!",
              new_balance: user.points_balance,
              redemption: redemption.to_json(include: { reward: { only: [ :name, :description, :cost ] } })
            }, status: :created
        else
            render json: { error: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
    end

  rescue ActiveRecord::RecordNotFound
    render json: { error: "User or Reward not found." }, status: :not_found
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def redemption_params
    params.require(:redemption).permit(:user_id, :reward_id)
  end
end
