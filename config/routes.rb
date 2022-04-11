Rails.application.routes.draw do
  # direct :root_url do
  #   "https://www.google.com"
  # end
  # root to: "members#show"
  resources :bicycles, only: [:index, :show, :create, :update, :destroy]
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  post '/invite', to: 'invite#invite'
  post '/invite/accept', to: 'invite#accept'
end
