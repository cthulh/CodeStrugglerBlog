class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: {minimum: 5}
	validates :body, presence: true

	scope :with_tag, -> (tag) { where("tags like ?", "%#{tag}%")}
end
