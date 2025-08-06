class Api::UsersController < ApplicationController
  before_action :set_user

  def show
    render json: @user.as_json(
      only: [ :id, :name, :email, :points_balance ],
    )
  end

  def points
    render json: { points_balance: @user.points_balance }
  end

  def redemptions
    redemptions = @user.redemptions.includes(:reward).order(redeemed_at: :desc)
    render json: redemptions.as_json(
      include: { reward: { only: [ :name, :description, :cost ] } },
    )
  end

  def add_points
    points = params[:points].to_i
    if points <= 0
      render json: { error: "Points must be greater than zero" }, status: :unprocessable_entity
      return
    end

    @user.points_balance += points
    if @user.save
      render json: { message: "#{points} points added successfully", points_balance: @user.points_balance }
    else
      render json: { error: "Failed to add #{points} points" }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end
end
