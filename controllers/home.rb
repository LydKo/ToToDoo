module ToDo
  module Controllers
    module Home
      include ToDo::Controller

      action 'Index' do
        include Lotus::Action::Session
      expose :tasks
      expose :user

        def call(params)
          user_id = session[:user]
          puts 'SESSION: #{user_id}'
          puts "MY PARAMS: #{params.inspect}"
          if params[:newest]
          @tasks = ToDo::Repositories::TaskRepository.latest_tasks(user_id)
        elsif params [:ABC]
          @tasks = ToDo::Repositories::TaskRepository.alphabetically(user_id)
        else 
          @tasks = ToDo::Repositories::TaskRepository.for_user(user_id)
          # vorher "all" = alle user - for_user = für best. user
        end
        puts "user #{session[:user]}"
        @user = ToDo::Repositories::UserRepository.by_id(session[:user])
      end
    end

          # Zeile 14: Befehl aus https://github.com/lotus/model -> repositories

          # Zeile 11: speichert die Eingabe 
          # vor Task den Pfad angeben

          # Zeile 10-15: ein task = Eingabe Nutzer
          # Zeile 19: tasks aus der Datenbank (Mehrzahl)
          # auch ändern in apllication.rb -> collection :tasks do
          # und setup.rb -> database.create_table! :tasks do 

          #puts @task.inspect
      
      action "Create" do

      include Lotus::Action::Session
      def call(params)
          #puts params.inspect
          new_task = ToDo::Models::Task.new({
            name: params[:task],
            user_id: session[:user]
          })
          # neuer Task angelegt mit Name und user_id für session (als hash)
          if !new_task.name.nil? && !new_task.name.strip.empty?
          # damit beim NeuLaden und bei Leerzeichen kein neuer Punkt erscheint
          # .strip: entfernt Leerzeichen aus String
          ToDo::Repositories::TaskRepository.create(new_task)
          # aus repositories-task_repository.rb (Pfad)
          end

          redirect_to "/"
          #geht zurück zur Startseite
        end

      end

      #CRUD = CREATE READ UPDATE DELETE - seperation of concerns! =actions voneinander trennen

      action 'Delete' do
        def call(params)
          task = ToDo::Repositories::TaskRepository.find(params[:task_id])
          ToDo::Repositories::TaskRepository.delete(task)
          #Server merkt sich hidden "id" des tasks der glöscht werden soll, 
          #speichert den in task über "find" und der wird dann übergeben und gelöscht

          redirect_to '/'
          #IST GELÖSCHT->geht zurück und lädt Seite neu
        end
      end
    end
  end
end
