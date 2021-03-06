Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users/edit' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  root "home#index"

  resources :users, :except => [:show] do
    collection do
      get 'picks'
    end
  end
  resources :bets, :only => [:index]
  post 'bets/update_bets', to: 'bets#update_many', as: 'update_bets'
  resources :match_days, :only => [:show, :index] do
    member do
      get 'finish'
      get 'picks'
    end
  end
  resources :leagues, :except => [:update, :edit]
  resources :user_leagues, :only => [:create, :destroy]

  resources :matches, :except => [:destroy, :show] do
    member do
      get 'edit_score'
      patch 'set_score'
    end
  end

  resources :players, :only => [:index, :edit, :update]
end
