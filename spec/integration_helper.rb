# rubocop:disable all
require 'spec_helper'
require_relative './factories/user_factory'

# TODO: ponerlo bien en el archivo web_mock
require 'webmock/rspec'

RSpec.configure do |config|
  config.include UserFactory
  config.after :each do
    Persistence::Repositories::PedidoRepository.new.delete_all
    Persistence::Repositories::UsuarioRepository.new.delete_all
    Persistence::Repositories::RepartidorRepository.new.delete_all
  end
end
