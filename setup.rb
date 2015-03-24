require 'bundler/setup'
#require 'sqlite3'
require 'lotus/model'
require 'lotus/model/adapters/sql_adapter'

require 'dotenv'
Dotenv.load

CONNECTION_URI = ENV['DATABASE_URL']

database = Sequel.connect(CONNECTION_URI)

database.create_table! :tasks do 
  primary_key :id
  String :name
  Integer :user_id #Fremdschlüssel auf Users-Tabelle
end

database.create_table! :users do
	primary_key :id
	string :email
	string :password
end
#legt Tabelle mit den Attributen an
#Primärschlüssel= eindeutig, kann auch Datum sein

#sqlite
#/
#v
#CREATE TABLE 'task' (id INTEGER PRIMARY KEY, name varchar (255));