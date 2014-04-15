class Mailer < ActionMailer::Base
  default from: Chienowa::Application.config.mail_from

  def comment_email(item_comment)
    @item_comment = item_comment
    mail(to: @item_comment.item.user.email, subject: "#{@item_comment.user.name} commented about your item")
  end

  def star_email(star)
    @star = star
    @user = User.find_by_name(star.author)
    mail(to: @user.email, subject: "#{@star.user.name} starred about your item") if @user
  end
end
