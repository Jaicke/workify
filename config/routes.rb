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
    resources :works, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      resources :work_versions, on: :member, except: :index
    end
    resources :reviews, only: [:index, :show, :new, :create, :edit, :update] do
      patch :replace, on: :member
      get :close, on: :member
    end
    resources :discussions, only: [:index, :edit, :update, :new, :create, :destroy, :show] do
      get :change_status, on: :member
      resources :discussion_answers, only: [:edit, :update, :create, :destroy] do
        get :toggle_favorite, on: :member
      end
    end
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
    #resources :students, only: []
    resources :connections, only: :index do
      get :accept, on: :member
      get :decline, on: :member
    end
    resources :home, only: :index
  end
end
