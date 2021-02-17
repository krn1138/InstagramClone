Rails.application.routes.draw do
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:index, :create, :destroy]

  root to: "pictures#index"
  resources :pictures do
   collection do
     post :confirm
     patch :confirm 
   end
   member do
     patch :confirm  
   end
  end
  resources :users do
    member do
      get :favorite_list
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
