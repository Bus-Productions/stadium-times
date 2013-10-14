StadiumTimes::Application.routes.draw do

  root :to => "posts#index"
  

  resources :post_and_topic_pairings


  resources :spams
  match 'spams/:post_id/:comment_id', to: 'spams#create', as: 'spam'


  resources :postviews


  resources :comment_votes


  resources :post_votes, only: [:create]
  match 'post_votes/:post_id/:vote', to: 'post_votes#create', as: 'vote'

  resources :comments

  match 'topic_follows/:topic_id/delete', to: 'topic_follows#destroy', as: 'unfollow_topic'
  match 'topic_follows/:topic_id', to: 'topic_follows#create', as: 'follow_topic'
  resources :topic_follows


  resources :topic_pairings


  resources :topics


  resources :posts
  match "posts/new/:post_type", to: "posts#new", as: "new_link"
  match 'posts/:id/publish', to: 'posts#publish', as: 'publish_post'


  resources :users, only: [:index, :show, :edit]
  match "users/:id/:display", to: "users#show", as: "users_display"


  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
