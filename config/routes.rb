JustAddGirls::Application.routes.draw do
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  match '/join' => 'users#join' #TODO: figure out how to automatically wire up causess conntroller
  match '/express-your-inner-geek' => 'causes#main', :as=> :main_cause
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
