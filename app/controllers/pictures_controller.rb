class PicturesController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
    redirect_to new_picture_path, notice: "投稿完了しました！"
    else
      # 入力フォームを再描画します。
      render :new
    end
  end

  def show
    # @picture = Picture.find(params[:id])
  end

  def edit
    # @picture = Picture.find(params[:id])
  end

  def update
    # @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "編集しました！"
    else
      render :edit
    end
  end


  private
  def picture_params
    params.require(:picture).permit(:image, :content)
  end

  def set_blog
    @picture = Picture.find(params[:id])
  end

end
