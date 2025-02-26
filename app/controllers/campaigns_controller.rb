class CampaignsController < ApplicationController
    before_action :set_campaign, only: [:show, :update, :destroy]
  
    # GET /campaigns
    def index
      @campaigns = Campaign.all
      render json: @campaigns
    end
  
    # GET /campaigns/:id
    def show
      render json: @campaign
    end
  
    # POST /campaigns
    def create
      @campaign = Campaign.new(campaign_params)
      if @campaign.save
        render json: @campaign, status: :created
      else
        render json: @campaign.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /campaigns/:id
    def update
      if @campaign.update(campaign_params)
        render json: @campaign
      else
        render json: @campaign.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /campaigns/:id
    def destroy
      @campaign.destroy
      head :no_content
    end
  
    private
  
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end
  
    def campaign_params
      params.require(:campaign).permit(:user_id, :name, :short_description, :description, :goal_amount, :current_amount, :perks, :backer_count, :slug)
    end
  end