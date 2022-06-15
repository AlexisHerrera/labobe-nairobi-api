# rubocop:disable all
ENV['RACK_ENV'] = 'test'
ENV['ENABLE_RESET'] = 'true'

require File.expand_path("#{File.dirname(__FILE__)}/../../config/boot")

require 'rspec/expectations'

if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  BASE_URL = 'http://localhost:3000'.freeze
  include Rack::Test::Methods
  def app
    Padrino.application
  end
end

def header
  {'Content-Type' => 'application/json'}
end

def crear_usuario_url
  "#{BASE_URL}/usuarios"
end

def obtener_menu_url
  "#{BASE_URL}/menu"
end

def reset_url
  "#{BASE_URL}/reset"
end

After do |_scenario|
  Faraday.post(reset_url)
end
