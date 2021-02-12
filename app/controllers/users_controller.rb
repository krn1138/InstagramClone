class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :move_to_signed_in, only: %i[ show edit update destroy ]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show #中身を追加
    @user = User.find(params[:id])
    @pictures = @user.pictures

    favorites = Favorite.where(user_id: current_user.id).pluck(:picture_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Picture.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
  end

  def favorite_list
    @favorites = Favorite.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
