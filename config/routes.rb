# frozen_string_literal: true

Rails.application.routes.draw do
  scope 'category' do
    get '/', to: 'categories#index'
    get '/show/:id', to: 'categories#show'
    post '/create', to: 'categories#create'
    patch '/update/:id', to: 'categories#update'
    delete '/delete/:id', to: 'categories#destroy'
  end
end
