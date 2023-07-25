Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
    root "root#index"

  devise_for :users, controllers: {
    sessions: 'api/users/sessions',
    registrations: 'api/users/registrations'
  }

  get 'current_user', to: 'members#index'

    namespace :api, defaults: { format: 'json' } do
      resources :products
    resources :reservations
    end

end
