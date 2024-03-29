Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Ckeditor::Engine => '/ckeditor'

  root to: 'site#home'
  get '/sign_up', to: 'site#sign_up'
  get '/sign_in', to: 'site#sign_in'

  namespace :student do
    resources :users, only: [:create]
    resource :password_resets, only: [:new, :create, :edit, :update]
    resources :notifications, only: :index do
      put :read, on: :member
    end

    resource :me, controller: "me", only: [:show, :update] do
      get :edit_profile, on: :member
      delete :remove_avatar, on: :member
      get :change_password, on: :member
      patch :update_password, on: :member
    end

    resource :sessions, only: [:create, :destroy]
    resources :teachers, only: [:index, :show] do
      post :send_connection, on: :member
    end
    resources :home, only: [:index] do
      get :events, on: :collection
    end
    resources :works, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      patch :restart, on: :member
      patch :conclude, on: :member
      resources :work_versions, on: :member, except: [:index, :destroy]
    end
    resources :reviews, only: [:index, :show, :new, :create, :edit, :update] do
      patch :replace, on: :member
      get :close, on: :member
    end
    resources :discussions, only: [:index, :edit, :update, :new, :create, :destroy, :show] do
      get :change_status, on: :member
      resources :discussion_answers, only: [:edit, :update, :create, :destroy] do
        get :toggle_like, on: :member
      end
    end
    resources :events, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  namespace :teacher do
    resources :users, only: [:create]
    resource :password_resets, only: [:new, :create, :edit, :update]
    resources :notifications, only: :index do
      put :read, on: :member
    end

    resource :me, controller: "me", only: [:show, :update] do
      get :edit_profile, on: :member
      delete :remove_avatar, on: :member
      get :change_password, on: :member
      patch :update_password, on: :member
    end

    resource :sessions, only: [:create, :destroy]
    resources :students, only: [:index, :show]
    resources :connections, only: :index do
      get :accept, on: :member
      get :decline, on: :member
    end
    resources :home, only: :index do
      get :events, on: :collection
    end
    resources :works, only: [:index, :show] do
      resources :work_versions, on: :member, only: :show
      get :current_version, to: 'work_versions#current_version'
    end
    resources :reviews, only: [:index, :show] do
      patch :approve, on: :member
    end
    resources :discussions, only: [:index, :edit, :update, :new, :create, :destroy, :show] do
      get :change_status, on: :member
      resources :discussion_answers, only: [:edit, :update, :create, :destroy] do
        get :toggle_like, on: :member
      end
    end
    resources :events, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
end
