# frozen_string_literal: true

Rails.application.routes.draw do
  scope 'category' do
    get '/', to: 'categories#index'
    get '/show/:id', to: 'categories#show'
    post '/create', to: 'categories#create'
    patch '/update/:id', to: 'categories#update'
    delete '/delete/:id', to: 'categories#destroy'
  end

  scope 'lesson' do
    get '/', to: 'lessons#index'
    get '/show/:id', to: 'lessons#show'
    post '/create', to: 'lessons#create'
    patch '/update/:id', to: 'lessons#update'
    delete '/delete/:id', to: 'lessons#destroy'
  end
end
