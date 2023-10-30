Rails.application.routes.draw do
  
  scope :api do
    scope :v1 do
      
      resources :users, only: [:update, :destroy]   # standard RESTful routes for users resource allowing only UPDATE/DESTROY
      post "/signup", to: "users#create"            # these are all custom routes for user related actions;
      get "/me", to: "users#show"                   # using POST/GET/DELETE and mapping to controller actions
      post "login", to: "sessions#create"           # in these cases either users or sessions controllers
      delete "/signout", to: "sessions#destroy"     #


      resources :posts , only: [:index, :create, :update, :show, :destroy] do     # use a block to nest comments inside posts; "/posts/:id/comments"
          resources :comments, shallow: true        # shallow-shortcut, limits routes generated for comments within posts to just the CREATE action AKA 'only: [:create]'
      end

      resources :comments, only: [:show]            # standard RESTful routes for comments resource allowing showing of comments
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

