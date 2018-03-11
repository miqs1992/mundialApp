Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users/edit' => 'devise/registrations#update', :as => 'user_registration'
  end
  
  root "home#index"

  resources :users, :except => [:show, :update, :edit] do
    resources :bets, :only => [:index]
  end
  
  resources :match_days, :only => [:show] do
    member do
      patch 'set_bets'
    end
  end

  resources :matches, :except => [:destroy, :show] do
    member do
      get 'edit_score'
      patch 'set_score'
    end
  end
  
end
