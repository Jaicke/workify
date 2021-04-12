Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'site#home'
  get '/sign_up', to: 'site#sign_up'
  get '/sign_in', to: 'site#sign_in'

  namespace :student do
    resources :users, only: [:create]

    resource :me, controller: "me", only: [:show, :update] do
      get :edit_profile, on: :member
      delete :remove_avatar, on: :member
      get :change_password, on: :member
      patch :update_password, on: :member
    end

    resource :sessions, only: [:create, :destroy]
    resources :teachers, only: :index do
      post :send_connection, on: :member
    end
    resources :home, only: :index
  end

  namespace :teacher do
    resources :users, only: [:create]

    resource :me, controller: "me", only: [:show, :update] do
      get :edit_profile, on: :member
      delete :remove_avatar, on: :member
      get :change_password, on: :member
      patch :update_password, on: :member
    end

    resource :sessions, only: [:create, :destroy]
    resources :students, only: [] do
      get :answer_connection, on: :collection
    end
    resources :home, only: :index
  end
end
