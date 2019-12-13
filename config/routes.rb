Rails.application.routes.draw do
  resources :projects
    namespace :api do
      namespace :v1 do
        get '/me', to: 'users#dashboard'
        post '/like', to: 'users#like'
        resources :users, only: [:create, :index, :show]
        resources :collaborators, only: [:create]
        get '/projects/:id/like', to: 'projects#like'
        resources :projects, only: [:index, :show, :create]
        resources :project_comments, only: [:create]
        resources :project_likes, only: [:create]     
        resources :comment_likes, only: [:create]     
        post '/login', to: 'auth#create'
        get '/validate', to: 'users#validate'
        get '/githubAuth', to: 'users#githubAuth'
        post '/search', to: 'searchs#search'
      end
    end
    get '/auth/:provider/callback', to: 'api/v1/users#github'
end
