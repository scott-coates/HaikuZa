class Point
	include Mongoid::Document
	field :point_type, type: Symbol
	field :value, type: Integer
	field :name, type: String
	belongs_to :haiku
	belongs_to :user
	belongs_to :voted_user, class_name:"User"
end