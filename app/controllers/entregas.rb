LaBobe::App.controllers :entregas, :provides => [:json] do
  get :show, :map => '/entregas' do
    begin
      entrega = Persistence::Repositories::EntregaRepository.new.find_by_id_pedido(params[:id_pedido])
      status 200
      # logger.info "Se informa el estado del pedido: #{pedido.id} con estado #{estado.descripcion}"
      entrega_to_json entrega
    rescue ObjectNotFound
      # Si se le indica un id_telegram inexistente, tambien cae aca
      status 404
      # logger.info "No se pudo encontrar el pedido #{params[:id_pedido]}"
      # {error: 'No se pudo encontrar el pedido.'}.to_json
    end
  end
end
