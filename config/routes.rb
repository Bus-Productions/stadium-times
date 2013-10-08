StadiumTimes::Application.routes.draw do

  resources :comments


  resources :topic_follows


  resources :topic_pairings


  resources :topics


  resources :posts


  root :to => "user#index"

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
