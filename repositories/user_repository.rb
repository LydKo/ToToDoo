
module ToDo
	module Repositories
		class UserRepository
			include Lotus::Repository
			#Schnittstelle zw Ruby und Datenbank

		 def self.by_id(user_id)
			query do
			where(id: user_id)
			end.first
		end

		 def self.find_by_email_and_password(email, password)
			query do
			where(email: email, password: password)
			end.first
			end
		end
	end
end