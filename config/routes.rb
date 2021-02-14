Rails.application.routes.draw do
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only: [:index, :create, :destroy]

# #6~11を追加
#   resources :users, only: [:new, :create, :show, :edit, :update] do
#     get :favorites, on: :collection
#   end
#   resources :pictures, expect: [:index] do
#     resources :favorites, only: [:create, :destroy]
#   end
  # resources :pictures do
  #   collection do
  #     post :confirm
  #   end
  # end
  root to: "pictures#index"
  resources :pictures do
   collection do
     post :confirm
     patch :confirm # confirm後のupdateに必要
   end
   member do
     patch :confirm  # confirm_blogs_pathの生成に必要
   end
  end
  resources :users do
    member do
      get :favorite_list
    end
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
