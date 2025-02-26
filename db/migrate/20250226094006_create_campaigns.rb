class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns do |t|
      t.integer :user_id
      t.string :name
      t.string :short_description
      t.text :description
      t.integer :goal_amount
      t.integer :current_amount
      t.text :perks
      t.integer :backer_count
      t.string :slug

      t.timestamps
    end
  end
end
