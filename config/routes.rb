Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: [:index, :show, :create, :update, :destroy] do
    collection do
      post 'login', to: 'sessions#login'
    end

    member do
      post 'upload_avatar', to: 'users#upload_avatar'
      delete 'remove_avatar', to: 'users#remove_avatar'
    end
  end

  resources :campaigns, only: [:index, :show, :create, :update, :destroy] do
    resources :campaign_images, only: [:create, :update, :destroy] do 
      member do
        post 'update_campaign_image', to: 'campaign_images#update_campaign_image'
        # delete 'delete_campaign_image', to: 'campaign_images#destroy_campaign_image'
      end

      collection do
        delete '', to: 'campaign_images#destroy_all'
      end
    end
  end
end
