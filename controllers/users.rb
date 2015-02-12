module ToDo
  module Controllers
    module Users
      include ToDo::Controller

      action 'New' do
        def call(params)
        end
      end

      action "Signin" do
        def call(params)
        end
      end

      action "Create" do

      def call(params)
          new_user = ToDo::Models::User.new({email: params[:email],
          #new neues Use-Objekt für ruby angelegt
          password: params[:password]})
          #Zuordnung Feld "email" zur Datenbankspalte "email"
          if !new_user.email.nil? && !new_user.email.strip.empty?
          ToDo::Repositories::UserRepository.create(new_user)
          #speichert User-Objekt in Datenbank-siehe Pfad
          end

          redirect_to "/"
          #geht zurück zur Startseite
        end

      end
    end
  end
end

