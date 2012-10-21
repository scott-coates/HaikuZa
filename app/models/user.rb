class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :screen_name, type: String
  field :email, type: String
  field :profile_image_url, type: String
  field :registered, type: Boolean
  attr_accessible :provider, :uid, :name, :screen_name, :email, :profile_image_url
  
  has_many :points
  
  index({ email: 1 }, { unique: true, background: true })

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.screen_name = auth['info']['nickname'] || ""
         user.email = auth['info']['email'] || ""
         user.profile_image_url = auth['info']['image'] || ""
         user.registered = true
      end
    end
  end

  def add_point(point)
    point[:user=>self];
    points.create!(point)
   end
end