# Clear existing data
User.destroy_all
Reward.destroy_all
Redemption.destroy_all


# Create default users
# Create users
users = User.create!([
  { name: "Aman", email: "aman@foo.com", points_balance: 150 },
  { name: "Sam", email: "sam@foo.com", points_balance: 300 }
])
puts "Created #{User.count} users."


# Create Rewards
reward1 = Reward.create!(name: 'Coffee Mug', description: 'A Thanx branded coffee mug.', cost: 100, limit: 50, available_from: DateTime.now - 1.month, available_until: DateTime.now + 1.month)
reward2 = Reward.create!(name: 'Gift Card ($25)', description: 'A $25 gift card to your favorite store.', cost: 500, limit: 100, available_from: DateTime.now - 1.month, available_until: DateTime.now + 1.month)
reward3 = Reward.create!(name: 'Thanx T-Shirt', description: 'Stylish Thanx T-shirt.', cost: 250, limit: 75, available_from: DateTime.now - 1.month, available_until: DateTime.now + 1.month)
reward4 = Reward.create!(name: 'Movie Ticket', description: 'One free movie ticket.', cost: 300, limit: 50, available_from: DateTime.now - 1.month, available_until: DateTime.now + 1.month)
reward5 = Reward.create!(name: 'Wireless Headphones', description: 'High-quality wireless headphones.', cost: 1500, limit: 25, available_from: DateTime.now - 1.month, available_until: DateTime.now + 1.month)

puts "Created #{Reward.count} rewards."


# Create some initial redemptions for testing
# Redemption.create!(user: users[0], reward: reward1, redeemed_at: DateTime.now - 2.days, points_spent: reward1.cost)
# Redemption.create!(user: users[0], reward: reward3, redeemed_at: DateTime.now - 1.day, points_spent: reward3.cost)

puts "Created #{Redemption.count} redemptions."
