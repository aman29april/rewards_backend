class CreateRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :rewards do |t|
      t.string :name, null: false
      t.text :description
      t.integer :cost, null: false

      t.integer :limit
      t.integer :redemptions_count, default: 0, null: false, index: true
      t.datetime :available_from, index: true
      t.datetime :available_until, index: true
      t.boolean :enabled, default: true, index: true

      t.timestamps
    end
  end
end
