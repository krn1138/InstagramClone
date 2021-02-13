class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :move_to_signed_in
  before_action :check_not_edit, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  #   if params[:back]
  #   @picture = Picture.new(picture_params)
  # else
  #   @picture = Picture.new
  #   end
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    # @picture = Picture.new(picture_params)
    # @picture.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "画像を投稿しました！"
      else
        render :new
      end
    end
  end

  # def confirm
  #   @picture = Picture.new(picture_params)
  #   render :new if @picture.invalid?
  # end
  def confirm
    # binding.pry
    @picture = current_user.pictures.build(picture_params)
    # @picture = Picture.new(picture_params)
    # @picture.user_id = current_user.id
    @picture.id = params[:id]
    # binding.pry
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
  # def picture_params
  #   params.require(:picture).permit(:image, :content)
  # end
  def picture_params
    params.require(:picture).permit(:id, :image, :content, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def check_not_edit
    # binding.pry
    unless current_user == @picture.user
      redirect_to  pictures_path, notice:"編集できません"
    end
  end

end
