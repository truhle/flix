Rails.application.routes.draw do

  resources :favorites
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

resources :movies do
  resources :reviews
end

end
