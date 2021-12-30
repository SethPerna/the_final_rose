Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bachelorettes
  resources :contestants
  resources :outings 

  get '/bachelorettes/:bachelorette_id/contestants', to: 'bachelorette_contestants#index'
end
