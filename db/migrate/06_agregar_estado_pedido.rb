Sequel.migration do
  up do
    add_column :pedidos, :id_estado, Integer, default: 3
  end

  down do
    drop_column :pedidos, :id_estado
  end
end
