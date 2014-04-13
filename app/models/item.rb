class Item < ActiveRecord::Base
  belongs_to :user
  has_many :histories, class_name: ItemHistory
  has_many :comments, class_name: ItemComment

  before_save {
    @before_item = Item.find_by_id(self.id)
  }

  after_save :item_saved

  default_scope -> { order('updated_at DESC') }
  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

  def item_saved
    new_revision = 1
    title_diff = content_diff = nil

    if @before_item
      new_revision = @before_item.histories.size + 1
      title_diff = self.title if self.title != @before_item.title
      if self.content != @before_item.content
        content_diff = Diffy::Diff.new(@before_item.content, self.content, include_diff_info: true, diff: "-U 1").to_s
      end
    else
      title_diff = self.title
      content_diff = Diffy::Diff.new("", self.content, include_diff_info: true, diff: "-U 1").to_s
    end

    if content_diff || title_diff
      item_history = create_item_history(new_revision, title_diff, content_diff)
      item_history.save!()
    end
  end

  def create_item_history(new_revision, title_diff, content_diff)
    item_history = ItemHistory.new(
                                   item: self,
                                   revision: new_revision,
                                   title: self.title,
                                   content: self.content,
                                   title_diff: title_diff,
                                   content_diff: content_diff
                                   )
  end
end
