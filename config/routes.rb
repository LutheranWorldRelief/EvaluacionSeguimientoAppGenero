Rails.application.routes.draw do
  
  devise_for :users
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }

  mount Ckeditor::Engine => '/ckeditor'
  root :to => "home#index"
  resources :home do
    member do
      post :insert_data
      get "results"
    end
    collection do
      get :edit_user
      put :update_user
    end
  end

  get "/home/survey/:id" => "home#show"

  namespace :admin do
	  resources :surveys do
      member do
        get "/admin/surveys/survey/:survey" => "surveys#show"
      end
    end
	  resources :sections do
      member do
        get "new_section"
      end
    end
    resources :questions do
      member do
        get "new_question"
      end
    end
    resources :answers
    resources :guides
    resources :admins
	end
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
