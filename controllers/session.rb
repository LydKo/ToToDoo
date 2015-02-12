module ToDo
  module Controllers
    module Sessions
      include ToDo::Controller

      action 'Create' do
        include Lotus::Action::Session
          def call(params)
          user = ToDo::Repositories::UserRepository.find_by_email_and_password(params[:email], params[:password])
          if user.nil?
            #user not found
            redirect_to '/users/signin'
          else
            #found smth. \o/
            session[:user] = user.id
            redirect_to '/'
          end
        end
      end


      action "Signout" do
        include Lotus::Action::Session
        def call(params)
        session[:user] = nil
        redirect_to "/"
        end

      end
    end
  end
end