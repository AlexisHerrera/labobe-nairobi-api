LaBobe::App.controllers :mock_clima, :provides => [:json] do
  post :create, :map => '/mock_lluvia' do
    if ENV['ENABLE_MOCK'] == 'true'
      configurar_clima(body_params[:clima])
      status 200
      return {estado: body_params[:clima]}.to_json
    end
    status 403
    {error: 'no permitido'}.to_json
  end

  get :show, :map => '/clima' do
    dia = DiaFactory.new.obtener_dia
    return {estado: 'Lluvia'}.to_json if dia.llueve?

    {estado: 'Soleado'}.to_json
  end
end
