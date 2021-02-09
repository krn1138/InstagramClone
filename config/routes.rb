Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  # resources :pictures do
  #   collection do
  #     post :confirm
  #   end
  # end
  resources :pictures do
   collection do
     post :confirm
     patch :confirm # confirm後のupdateに必要
   end
   member do
     patch :confirm  # confirm_blogs_pathの生成に必要
   end
  end
end
