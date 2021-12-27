Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"

  scope 'api/v1' do
    devise_for :users, controllers: {
      sessions: 'api/v1/sessions'
    }, json: true
  end
  post '/graphql', to: 'graphql#execute'
  namespace :api do
    namespace :v1 do
      resources :pictures, only: %i[create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
