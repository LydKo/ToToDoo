
module ToDo
	module Repositories
		class TaskRepository
			include Lotus::Repository

			# Aufgaben für einen bestimmten Nutzer laden
			def self.for_user(user_id)
				query do
					#SELECT from users WHERE user_id = x (wählt/zeigt nur bestimmte Eigenschaften aus/an)
					# x entspricht dem parameter user_id
					where(user_id: user_id)
				end
			end

			# Sortiermethoden 1. das Letzte zum Schluss =desc  / 2.Alphabetisch = asc
			def self.latest_tasks(user_id)
				query do 
					where(user_id: user_id).desc(:id)
					#mit Punkt trennen, versch. Parameter beifügen
					# ordned desc (=absteigend) nach ID
				end
			end

			def self.alphabetically(user_id)
				query do
					where(user_id: user_id).asc(:name)
					# ordnet asc (=aufsteigend) nach Name 
				end
			end
		end
	end
end



