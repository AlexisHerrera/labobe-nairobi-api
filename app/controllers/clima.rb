LaBobe::App.controllers :mock_clima, :provides => [:json] do
  post :create, :map => '/mock_lluvia' do
    # TODO: no permitir mockear siempre la lluvia si estoy en produccion
    configurar_clima(body_params[:clima])
    status 200
    {message: 'Hoy esta lloviendo'}.to_json
  end

  get :show, :map => '/clima' do
    dia = DiaFactory.new.obtener_dia
    return {estado: 'Lluvia'}.to_json if dia.llueve?

    {estado: 'Soleado'}.to_json
  end
end
