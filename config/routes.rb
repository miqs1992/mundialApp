Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users/edit' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  root "home#index"

  resources :users, :except => [:show]
  resources :bets, :only => [:index]
  post 'bets/update_bets', to: 'bets#update_many', as: 'update_bets'
  resources :match_days, :only => [:show, :index]
  resources :leagues, :except => [:update, :edit]

  resources :matches, :except => [:destroy, :show] do
    member do
      get 'edit_score'
      patch 'set_score'
    end
  end
end
