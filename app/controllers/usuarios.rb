WebTemplate::App.controllers :usuarios, :provides => [:json] do
  post :create, :map => '/usuarios' do
    status 201
  end
end
