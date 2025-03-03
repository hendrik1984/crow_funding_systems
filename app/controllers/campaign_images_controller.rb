class CampaignImagesController < ApplicationController
    before_action :authenticate_request, only: [:create, :update_campaign_image, :destroy]
  
    # POST /campaign_images
    def create
        uploaded_campaign_images = []
        image_count = 1
        campaign_id = params[:campaign_id]
        images = params[:images]

        if images.blank?
            render_json("No images provided", 400, "error")
            return
        end
        
        images.each do |image|
            
            image_is_primary = params[:is_primary].to_i == image_count ? true : false
            filename = "campaign-#{campaign_id}-#{image.original_filename}"
            filepath = Rails.root.join("public", "images", filename)
            
            # create new campaignImage record
            campaign_image = CampaignImage.new(campaign_image_params)
            campaign_image.filename = filename
            campaign_image.is_primary = false unless image_is_primary
            
            if campaign_image.save
                File.open(filepath, 'wb') do |file|
                    file.write(image.read)
                end
                uploaded_campaign_images << filename
            else
                #Rollback if there is an error
                uploaded_campaign_images.each do |uci|
                    filepath = Rails.root.join('public', 'images', uci.filename)
                    File.delete(filepath) if File.exist?(filepath)
                end
                render_json("Failed to save campaign images", 422, "error", campaign_image.errors)
            end

            image_count += 1
        end

        render_json("Campaign Image uploaded successfully", 201, "success", uploaded_campaign_images)
    end

    # update campaign image can't use PUT/PATCH method the file will not detected. use POST instead
    def update_campaign_image
        id = params[:id]
        campaign_id = params[:campaign_id]
        images = params[:images]

        if images.blank?
            render_json("No images provided", 400, "error")
            return
        end

        #find the current image and delete it
        find_campaign_image = CampaignImage.find_by(:campaign_id => campaign_id, :id => id)
        if find_campaign_image.nil?
            render_json("No images or datas found", 422, "error")
            return
        end

        filename = find_campaign_image.filename
        filepath = Rails.root.join("public", "images", filename)
        
        #delete the current campaign image
        File.delete(filepath) if File.exist?(filepath)
        
        filename = "campaign-#{campaign_id}-#{images.original_filename}"
        filepath = Rails.root.join("public", "images", filename)
        find_campaign_image.filename = filename
        
        if find_campaign_image.update(campaign_image_params)
            File.open(filepath, 'wb') do |file|
                file.write(images.read)
            end
            render_json("Campaign image successfully updated", 200, "success", find_campaign_image)
        else
            render_json("Failed to save campaign images", 422, "error", find_campaign_image.errors)
        end
    end
    
    # Delete campaigns/:id/campaign_images
    def destroy_all
        find_campaign_images = CampaignImage.where(:campaign_id => params[:campaign_id])

        if find_campaign_images
            find_campaign_images.each do |image|
                # Destroy the image
                filepath = Rails.root.join("public", "images", image.filename)
                File.delete(filepath) if File.exist?(filepath)

                image.destroy
            end
            render_json("Campaign images succesfully destroyed", 200, "success")
        else
            render_json("Campaign images not found", 422, "error")
        end
    end

     # DELETE campaigns/:id/campaign_images/:id
    def destroy
        id = params[:id]
        campaign_id = params[:campaign_id]
        
        find_campaign_image = CampaignImage.find_by(:campaign_id => campaign_id, :id => id)
        if find_campaign_image.nil?
            render_json("No images or datas found", 422, "error")
            return
        end
        
        find_campaign_image.destroy

        #delete the current campaign image
        filepath = Rails.root.join("public", "images", find_campaign_image.filename)
        File.delete(filepath) if File.exist?(filepath)

        render_json("Campaign Image destroyed", 200, "success")
    end
  
    private
  
    def campaign_image_params
        params.permit(:id, :campaign_id, :filename, :is_primary, :images, images: [])
    end
  end