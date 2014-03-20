class ItemHistory < ActiveRecord::Base
  validates :item_id, presence: true
  validates :revision, presence: true, uniqueness: { scope: :item_id }
  validates :title, presence: true
  validates :content, presence: true
end
