Sequel.migration do
  up do
    add_column :pedidos, :calificacion, String, default: 'sin calificacion'
  end

  down do
    drop_column :pedidos, :calificacion
  end
end
