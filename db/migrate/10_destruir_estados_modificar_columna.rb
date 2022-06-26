Sequel.migration do
  up do
    drop_table(:estados)
    drop_column :pedidos, :id_estado
    add_column :pedidos, :estado, String, default: 'Entregado'
  end

  down do
    create_table(:estados) do
      primary_key :id
      String :descripcion
      Date :created_on
      Date :updated_on
    end
    drop_column :pedidos, :estado
    add_column :pedidos, :id_estado, Integer, default: 3
  end
end
