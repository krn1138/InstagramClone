class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :move_to_signed_in
  before_action :check_not_edit, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        PostMailer.post_mail(@picture).deliver
        redirect_to pictures_path, notice: "画像を投稿しました！"
      else
        render :new
      end
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    @picture.id = params[:id]
    render :new if @picture.invalid?
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit

  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path,　notice:"更新しました!"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"削除しました！"
  end

  private
  def picture_params
    params.require(:picture).permit(:id, :image, :content, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def check_not_edit
    unless current_user == @picture.user
      redirect_to  pictures_path, notice:"編集できません"
    end
  end

end
