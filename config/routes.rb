StadiumTimes::Application.routes.draw do

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


  resources :user, only: [:index, :show]



  root :to => "posts#index"

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
