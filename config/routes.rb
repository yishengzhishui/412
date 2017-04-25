Rails.application.routes.draw do
  devise_for :users

  resources :jobs do
    member do
      post :join
      post :quit
    end
    resources :resumes
    collection do
      get :search
    end
  end



  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end

      resources :resumes
    end
  end


  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
