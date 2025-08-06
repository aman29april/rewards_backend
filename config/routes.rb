# == Route Map
#
#               Prefix Verb URI Pattern                          Controller#Action
#          api_rewards GET  /api/rewards(.:format)               api/rewards#index
#      api_redemptions POST /api/redemptions(.:format)           api/redemptions#create
#      points_api_user GET  /api/users/:id/points(.:format)      api/users#points
# redemptions_api_user GET  /api/users/:id/redemptions(.:format) api/users#redemptions
#  add_points_api_user POST /api/users/:id/add_points(.:format)  api/users#add_points
#             api_user GET  /api/users/:id(.:format)             api/users#show

Rails.application.routes.draw do
  namespace :api do
    resources :rewards, only: [ :index ] # GET /api/rewards
    resources :redemptions, only: [ :create ] # POST /api/redemptions

    resources :users, only: [ :show ] do
      member do
        get "points" # GET /api/users/:id/points
        get "redemptions" # GET /api/users/:id/redemptions
        post "add_points" # POST /api/users/:id/add_points
      end
    end
  end
end
