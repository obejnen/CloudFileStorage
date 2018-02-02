Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "devise_override/registrations" }
  root "folders#show"
  get "folders/shared", to: "folders#show_shared"
  resources :folders do
    resources :folders
    resources :items
  end

  post "/item_share_with", to: "items#share_with"
  post "/folder_share_with", to: "folders#share_with"
  post "/folder_rename", to: "folders#edit"
  post "/item_rename", to: "items#edit"
  # get action: '/download_file', controller: "items", to: "items#download"
  resources :items do
    get '/download_file', to: "items#download"
  end
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
