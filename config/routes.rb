Rails.application.routes.draw do

resources :genres
resource :session
get "signup" => 'users#new'
get "signin" => 'sessions#new'
resources :users
root "movies#index"
# get "/movies" => "movies#index"
# get "/movies/new" => "movies#new"
# get "/movies/:id" => "movies#show", as: "movie"
# get "/movies/:id/edit" => "movies#edit", as: "edit_movie"
# patch "/movies/:id" => "movies#update"
# get "movies/filter/hits" => "movies#index", scope: "hits"
# get "movies/filter/flops" => "movies#index", scope: "flops"
get "movies/filter/:scope" => "movies#index", as: :filtered_movies
resources :movies do
  resources :reviews
  resources :favorites
end

end
