Rails.application.routes.draw do
  
  

  # custom route example for "/posts/:id/comments";
  get "/ordered-posts", to: "posts#ordered"

  # to build a custom route to get all comments to show; name of controller (comments)
  # along with #action;
  get "/comments", to: "comments#index"
  # but now there are two routes that go to same place but need to so different
  # things so we need to somehow differentiate. 
  # 
  
  resources :users, only: [:update, :destroy]
  post "/signup", to: "users#create"
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"



# to nest comments inside the posts use a block like below;
# only useful when indexed, not when updating or destroying 
# rails is opinionated so it has a shallow that will only create routes that are needed
# if shallow isnt used you would need to specify, only: [:index, :create, :] etc etc
  "/posts/:id/comments"
  resources :posts do
    resources :comments, shallow: true
  end
end
