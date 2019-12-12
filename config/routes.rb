Rails.application.routes.draw do
  resources :projects
    namespace :api do
      namespace :v1 do
        get '/me', to: 'users#dashboard'
        resources :users, only: [:create, :index, :show]
        resources :projects, only: [:index, :show]
        resources :project_comments, only: [:create]
        post '/login', to: 'auth#create'
        get '/validate', to: 'users#validate'
        get '/githubAuth', to: 'users#githubAuth'
        get '/repos', to: 'users#repos'
      end
    end
    get '/auth/:provider/callback', to: 'api/v1/users#github'
end
