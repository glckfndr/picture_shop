Rails.application.routes.draw do
  root "products#index"

  resources :products  do
    member do
      resource :carts do
        [:plus, :minus, :del].each do |action|
          post action, to: "carts#update", as: "#{action}_product_to", defaults: {action_type: "#{action}"}
        end
      end
      post :add, to: "products#update", defaults: {action_type: "add"}
      post :remove, to: "products#update",  defaults: {action_type: "remove"}
    end
  end

  delete '/empty', to: 'carts#empty'
  get '/cart', to: 'carts#show'
  resources :orders
end
