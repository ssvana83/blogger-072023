Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :posts
  # whats really happening is you get the 5(6) default RESTful routes;
  # get "/posts", to: "posts#index"
  # get "/posts/:id", to: "posts#show"
  # post  "/posts", to: "posts#create"
  # patch "/posts/:id", to: "posts#update" similar to put "/posts/:id", to: "posts#update"
  # delete "/posts/:id", to: "posts#destroy"

  # custom route example
  get "/ordered-posts", to: "posts#ordered"
  # "/posts/:id/comments"

# to nest comments inside the posts use a block like below;
# only useful when indexed, not when updating or destroying 
# rails is opinionated so it has a shallow that will only create routes that are needed
# if shallow isnt used you would need to specify, only: [:index, :create, :] etc etc
  "/posts/:id/comments"
  resources :posts do
    resources :comments, shallow: true
  end
end
