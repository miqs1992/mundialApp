Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             :skip => [:registrations, :password]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users/edit' => 'devise/registrations#update', :as => 'user_registration'

    get 'users/password/edit' => 'devise/passwords#edit', :as => 'edit_user_password'
    patch 'users/password/edit' => 'devise/passwords#update', :as => 'user_password'
  end
  
  root "home#index"
end
