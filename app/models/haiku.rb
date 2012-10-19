class Haiku
	include Mongoid::Document
	 field :screen_name, type: String
	 field :tweet_id, type: Integer
	 field :content, type: String

	 attr_accessible :screen_name, :tweet_id, :content
	 index({ tweet_id: -1 }) #TODO: find way to queue this index without having to rake manually
end