module ToDo
	module Models
		class User
			include Lotus::Entity
			self.attributes = :email, :password
			# Usereigenschaften
			
		end
	end
end