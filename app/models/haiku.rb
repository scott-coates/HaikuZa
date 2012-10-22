class Haiku
	include Mongoid::Document
	include Mongoid::Timestamps
	 field :screen_name, type: String
	 field :tweet_id, type: Integer
	 field :content, type: String
	 belongs_to :user

	 attr_accessible :screen_name, :tweet_id, :content
	 index({ tweet_id: -1 })
	 index({ points: -1 })
end