Rails.application.routes.draw do
  root "products#index"
  post '/add_to_cart', to: 'carts#update'
  post '/remove_from_cart', to: 'carts#delete'
  post '/plus', to: 'carts#plus'
  post '/minus', to: 'carts#minus'
  post '/del', to: 'carts#del'

  get '/cart', to: 'carts#show'

  resources :products, :orders
end
