StadiumTimes::Application.routes.draw do

  root :to => "posts#index"
  

  resources :post_and_topic_pairings


  resources :spams


  resources :postviews


  resources :comment_votes


  resources :post_votes


  resources :comments


  resources :topic_follows


  resources :topic_pairings


  resources :topics


  resources :posts
  match "posts/new/:post_type", to: "posts#new", as: "new_link"


  resources :users, only: [:index, :show, :edit]
  match "users/:id/:display", to: "users#show", as: "users_display"


  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
