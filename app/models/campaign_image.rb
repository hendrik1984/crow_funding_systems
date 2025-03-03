class CampaignImage < ApplicationRecord
    belongs_to :campaign

    attr_accessor :images

    # validates :campaign_id, presence: true
    # validates :filename, presence: true
    validates :is_primary, inclusion: { in: [true, false] }
    
end
