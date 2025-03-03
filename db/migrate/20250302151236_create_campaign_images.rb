class CreateCampaignImages < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_images do |t|
      t.integer :campaign_id
      t.string :filename
      t.boolean :is_primary

      t.timestamps
    end
  end
end
