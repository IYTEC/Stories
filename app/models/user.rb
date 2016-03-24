class User < ActiveRecord::Base
	has_many :articles
	def self.find_or_create_from_user(auth_hash)
		user = where(:provider => auth_hash.provider, :uid => auth_hash.uid).first_or_create
		user.update(
			provider: auth_hash.provider,
			uid: auth_hash.uid,
			name: auth_hash.info.name,
			image: auth_hash.info.image,
			token: auth_hash.credentials.token
			)
		user
	end

	def facebook
		@client ||= Koala::Facebook::API.new(token)
	end
end
