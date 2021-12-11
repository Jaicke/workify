Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Ckeditor::Engine => '/ckeditor'

  notify_to :student_users, controller: 'student/notifications'
  notify_to :teacher_users, controller: 'teacher/notifications'

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
    resources :teachers, only: [:index, :show] do
      post :send_connection, on: :member
    end
    resources :home, only: [:index] do
      get :events, on: :collection
    end
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
        get :toggle_like, on: :member
      end
    end
    resources :events, only: [:index, :new, :create, :show, :edit, :update, :destroy]
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
  end
end
