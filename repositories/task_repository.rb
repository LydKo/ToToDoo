
module ToDo
	module Repositories
		class TaskRepository
			include Lotus::Repository

			# Sortiermethoden 1. das Letzte zum Schluss =desc  / 2.Alphabetisch = asc
			def self.latest_tasks
				query do 
					desc(:id)
					# ordned desc (=absteigend) nach ID
				end
			end

			def self.alphabetically
				query do
					asc(:name)
					# ordnet asc (=aufsteigend) nach Name 
				end
			end
		end
	end
end



