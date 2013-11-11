StadiumTimes::Application.routes.draw do

  resources :device_tokens


  root :to => "posts#index"
  match "index", to: "posts#index"

  resources :post_and_topic_pairings


  resources :spams, only: [:create]
  match 'spams/:post_id/:comment_id', to: 'spams#create', as: 'spam'


  resources :comment_votes, only: [:create]


  resources :post_votes, only: [:create]
  match 'post_votes/:post_id/:vote', to: 'post_votes#create', as: 'vote'

  resources :comments, only: [:show, :create]

  match 'topic_follows/:topic_id/delete', to: 'topic_follows#destroy', as: 'unfollow_topic'
  match 'topic_follows/:topic_id', to: 'topic_follows#create', as: 'follow_topic'
  resources :topic_follows, only: [:create, :destroy]


  # resources :topics


  resources :posts, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  match "posts/new/:post_type", to: "posts#new", as: "new_link"
  match 'posts/:id/publish', to: 'posts#publish', as: 'publish_post'
  match "posts/:id/:slug", to: "posts#show", as: "show_post"
  match 'posts/search', to: 'posts#search', as: 'search'



  resources :users, only: [:show, :edit, :update]
  match "users/:id/:display", to: "users#show", as: "users_display"


  resources :device_tokens, only: [:create, :update]


  match 'auth/mobile', to: 'sessions#create_mobile'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signup/:verify', to: 'posts#index', as: 'verify_login'
  match 'signout', to: 'sessions#destroy', as: 'signout'

  match 'help', to: 'pages#help', as: "pages_help"
  match 'about', to: 'pages#about', as: "pages_about"
  match 'legal', to: 'pages#legal', as: "pages_legal"
  match 'stadium', to: 'pages#stadium', as: "pages_stadium"

end
