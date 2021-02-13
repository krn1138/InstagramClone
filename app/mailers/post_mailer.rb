class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: "krn971138@gmail.com", subject: "投稿確認メール"
  end
end
