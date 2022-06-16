Sequel.migration do
  up do
    create_table(:pedidos) do
      primary_key :id
      String :id_usuario
      Int :id_menu
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:pedidos)
  end
end
