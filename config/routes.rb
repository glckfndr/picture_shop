Rails.application.routes.draw do
  root "products#index"
  resources :products  do
    member do
      post :add, to: "products#update"
      post :remove, to: "products#update"
      post :plus, to: "carts#update"
      post :minus, to: "carts#update"
      post :del, to: "carts#update"
    end
  end

  delete '/empty', to: 'carts#empty'
  get '/cart', to: 'carts#show'
  resources :orders
end
