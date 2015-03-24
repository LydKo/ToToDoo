require 'lotus'
require 'lotus/model'
require 'lotus/action/session'

module ToDo
  class Application < Lotus::Application
    configure do
      routes do
        get '/', to: 'home#index' #leitet es an server und zurück zum browser
        post '/tasks/create',   to: 'home#create'
        post '/tasks/delete',   to: 'home#delete'
        get '/impressum',       to: 'imprint#page'
        get '/users/new',       to: 'users#new'
        get 'users/signin',     to: 'users#signin'
        post 'users/create',    to: 'users#create'
        post 'sessions/create', to: 'sessions#create'
        post 'sessions/signout',to: 'sessions#signout'
        # Reihenfolge wichtig, da er von oben nach unten durchsucht und ausführt
      end

      load_paths << [
        'controllers',
        'models',
        'views',
        'repositories'
      ]
      layout :application
    end

    load!
  end

  require 'dotenv'
  Datenv.load

  CONNECTION_URI = ENV['DATABASE_URL']
  Lotus::Model.configure do
    adapter type: :sql, uri: CONNECTION_URI

# mapping: Verknüpfen Tabelle in Datenbank mit Anwendung
  mapping do
    collection :tasks do
    entity     ToDo::Models::Task
    repository ToDo::Repositories::TaskRepository

    attribute :id, Integer
    attribute :name, String
    attribute :user_id, Integer
   end

    collection :users do
    entity ToDo::Models::User
    repository ToDo::Repositories::UserRepository
    #Verbindung der Dateien

    attribute :id, Integer
    attribute :email, String
    attribute :password, String
    #die Eigenschaften werden mit Datenbank verknüpft
    end
  end
end

Lotus::Model.load!
end

def h(text)
  Rack::Utils.escape_html(text)
  # ersetzt spitze KLammern <...> damit User keine Anwendungen starten kann
  # = Input bereinigen
  # Methode wird bei home-index.html.erb aufgerufen
end
