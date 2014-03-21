class ItemHistory < ActiveRecord::Base
  belongs_to :item
  default_scope -> { order('revision DESC') }

  validates :item_id, presence: true
  validates :revision, presence: true, uniqueness: { scope: :item_id }
  validates :title, presence: true
  validates :content, presence: true
end
