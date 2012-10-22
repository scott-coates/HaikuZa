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

	after_create do |point|
		if point.haiku
			point.haiku.points ||= 0
			point.haiku.points += point.value 
			point.haiku.save!
		end	
	end
end