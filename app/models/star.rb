class Star < ActiveRecord::Base
  belongs_to :user

  validates :site_id, presence: true
  validates :item_id, presence: true
  validates :url, presence: true
  validates :user_id, presence: true, uniqueness: { scope: [:site_id, :item_id] }

  default_scope -> { order('updated_at DESC') }
end
