module ToDo
	module Models
		class Task
			include Lotus::Entity
			self.attributes = :name, :user_id
		end
	end
end