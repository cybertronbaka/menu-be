Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "api/v1/sessions"
  }, json: true
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end
