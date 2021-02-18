class PostMailer < ApplicationMailer
  def post_mail(picture)
    @picture = picture
    mail to: @picture.user.email, subject: "投稿確認メール"
  end
end
