Rails.application.routes.draw do
  devise_for :users


    namespace :api, defaults: { format: 'json' } do
      resources :users
     resources :products
    resources :reservations
    end

end
