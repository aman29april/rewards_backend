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
FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) { |n| "test#{n}@example.com" }
    points_balance { 500 }
  end
end
