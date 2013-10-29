StadiumTimes::Application.routes.draw do

  root :to => "posts#index"
  

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



  resources :users, only: [:show, :edit]
  match "users/:id/:display", to: "users#show", as: "users_display"


  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  match 'help', to: 'pages#help', as: "pages_help"
  match 'about', to: 'pages#about', as: "pages_about"
  match 'legal', to: 'pages#legal', as: "pages_legal"
  match 'stadium', to: 'pages#stadium', as: "pages_stadium"


end
