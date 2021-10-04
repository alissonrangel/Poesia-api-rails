Rails.application.routes.draw do
  resources :poetries
  resources :users

  get 'me', to: 'users#me'

  post 'signin', to: 'users#signin'
  post 'signup', to: 'users#signup'

  get 'listpoetries', to: 'poetries#poetries'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
