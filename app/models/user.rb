class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :profile_image_url, type: String
  field :registered, type: Boolean
  attr_accessible :provider, :uid, :name, :email, :profile_image_url
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.profile_image_url = auth['info']['image'] || ""
         user.registered = true
      end
    end
  end
end