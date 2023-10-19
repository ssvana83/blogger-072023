Rails.application.routes.draw do
  
  scope :api do
    scope :v1 do
      # get "/ordered-posts", to: "posts#ordered" # custom route example for "/posts/:id/comments"
      get "/comments", to: "comments#index" # custom route has task(get), name of controller(/comments), and action(#index) 
      get "/posts", to: "posts#index" 
  
      resources :users, only: [:update, :destroy]
      post "/signup", to: "users#create"
      get "/me", to: "users#show"
      post "login", to: "sessions#create"
      delete "/logout", to: "sessions#destroy"

      resources :comments, only: [:index]
      resources :posts, only: [:index, :create, :update]
# change above to resources :posts, only: [:destroy] ??
      
      

      resources :posts do  #use a block to nest comments inside posts; "/posts/:id/comments"
          resources :comments, shallow: true #shallow-shortcut, only creates routes neeeded (dont need to specify only: [:index, :create] etc etc)
      end
    end
  end
end
#  RESTful routes created manually;
#  get "/posts", to: "posts#index" (display all posts)
#  get "/posts/:id", to: "posts#show" (a specific/or one post)
#  post "/posts", to: "posts#create" (to post)
#  patch "/posts/:id", to: "posts#update" (to edit)
#  put "/posts/:id", to: "posts#update" (to edit)
#  delete "/posts/:id", to: "posts#destroy" (to delete)

# resources is a macro that creates all the default routes for us
# you can nest routes by putting comments in posts
