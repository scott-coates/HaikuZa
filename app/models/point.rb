class Point
	include Mongoid::Document
	include Mongoid::Timestamps
	field :point_type, type: Symbol
	field :value, type: Integer
	field :name, type: String
	field :notified, type: Boolean
	belongs_to :haiku
	belongs_to :user
	belongs_to :voted_user, class_name:"User"
	index({ no_op_index: 1 })

	after_create do |point|
		if point.point_type == :retweet && point.haiku
			point.haiku.points ||= 0
			point.haiku.points += point.value 
			point.haiku.save!
		end	
	end
end