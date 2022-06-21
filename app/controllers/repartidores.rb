LaBobe::App.controllers :repartidores, :provides => [:json] do
  post :create, :map => '/repartidores' do
    status 201
  end
end
