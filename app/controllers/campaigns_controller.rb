class CampaignsController < ApplicationController
    before_action :authenticate_request, only: [:index, :show, :create, :update, :destroy]
    before_action :set_campaign, only: [:show, :update, :destroy]
  
    # GET /campaigns
    def index
        @campaigns = Campaign.all
        render_json("Campaigns retrieved successfully", 200, "success", @campaigns)
    end
  
    # GET /campaigns/:id
    def show
        render_json("Campaign retrieved successfully", 200, "success", @campaign)
    end
  
    # POST /campaigns
    def create
        @campaign = Campaign.new(campaign_params)
        @campaign.user_id = current_user[:user_id]
        if @campaign.save
            render_json("Campaign created successfully", 200, "success", @campaign)
        else
            render_json("Campaign creation failed", 422, "error", @campaign.errors)
        end
    end
  
    # PATCH/PUT /campaigns/:id
    def update
        if @campaign.update(campaign_params)
            render_json("Campaign updated successfully", 200, "success", @campaign)
        else
            render_json("Campaign update failed", 422, "error", @campaign.errors)
        end
    end
  
    # DELETE /campaigns/:id
    def destroy
        @campaign.destroy
        render_json("Campaign deleted successfully", 200, "success")
    end
  
    private
  
    def set_campaign
        @campaign = Campaign.find(params[:id])
    end
  
    def campaign_params
        params.require(:campaign).permit(:user_id, :name, :short_description, :description, :goal_amount, :current_amount, :perks, :backer_count, :slug)
    end
  end