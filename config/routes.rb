Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/jquery-1', to: 'pages#jquery_1'
  get '/jquery-2', to: 'pages#jquery_2'
  get '/jquery-3', to: 'pages#jquery_3'
  get '/jquery-4', to: 'pages#jquery_4'
  get '/jquery-5', to: 'pages#jquery_5'

  resources :posts
end
