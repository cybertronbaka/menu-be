Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  mount ActionCable.server => "/cable"
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope 'api/v1' do
    devise_for :users, controllers: {
      sessions: 'api/v1/sessions'
    }, json: true
    devise_scope :user do
      get :authenticated, controller: 'api/v1/sessions', action: :authenticated
    end
  end
  post '/graphql', to: 'graphql#execute'
  namespace :api do
    namespace :v1 do
      resources :pictures, only: %i[create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
