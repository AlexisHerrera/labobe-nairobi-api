LaBobe::App.controllers :pedidos, :provides => [:json] do
  post :create, :map => '/pedidos' do
    # nuevo_pedido = CreadorDePedidos.new(pedido_repo).crear_pedido(pedido_params[:id_usuario],pedido_params[:id_pedido] )
    status 201
  end
end
