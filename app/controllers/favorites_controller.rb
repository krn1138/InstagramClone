class FavoritesController < ApplicationController

  def index
     # binding.irb
     @favorites = current_user.favorite_list
  end

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to pictures_url, notice: "#{favorite.picture.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to pictures_url, notice: "#{favorite.picture.user.name}さんのブログをお気に入り解除しました"
  end
end

# #ここからqiita記事参考
# class FavoritesController < ApplicationController
#
#   before_action :set_post
#   before_action :authenticate_user!   # ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）
#
# 　def index
# end
#   # お気に入り登録
#   def create
#     if @picture.user_id != current_user.id   # 投稿者本人以外に限定
#       @favorite = Favorite.create(user_id: current_user.id, picture_id: @picture.id)
#     end
#   end
#   # お気に入り削除
#   def destroy
#     @favorite = Favorite.find_by(user_id: current_user.id, picture_id: @picture.id)
#     @favorite.destroy
#   end
#
#   private
#   def set_post
#     @picture = Picture.find(params[:picture_id])
#   end
