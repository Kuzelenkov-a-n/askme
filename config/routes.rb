Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resource :session, only: %i[new create destroy]
  resources :questions, except: %i[show new index]
  resources :hashtags, only: %i[show], param: :text
end
