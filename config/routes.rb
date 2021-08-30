Rails.application.routes.draw do
  
  devise_for :users
  devise_for :admins, path: 'admins', controllers: { sessions: 'admins/sessions' }

  mount Ckeditor::Engine => '/ckeditor'
  root :to => "home#index"

  get "/home/records/" => "home#records"
  get "/home/historic/" => "home#historic"
  get "/home/results/" => "home#results"
  post "/home/delete" => "home#delete"
  post "/home/insert_data" =>"home#insert_data"
  post "/home/archived" => "home#archived"
  post "/home/unarchived" => "home#unarchived"

  resources :home do
    collection do
      get :edit_user
      put :update_user
    end
  end

  # :id => survey ID, :did => diagnostic ID
  get "/home/survey/:id(/:did)" => "home#show"

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
