# config.ru
require 'lotus'
require_relative 'application'

use Rack::Session::Cookie, secret: SecureRandom.hex(64)

run ToDo::Application.new
