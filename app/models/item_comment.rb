class ItemComment < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  validates :item_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true

  after_save :item_comment_saved

  def item_comment_saved
    Mailer.comment_email(self).deliver
  end

end
