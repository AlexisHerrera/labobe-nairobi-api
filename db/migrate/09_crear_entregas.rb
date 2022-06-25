Sequel.migration do
  up do
    create_table(:entregas) do
      primary_key :id
      foreign_key :id_pedido, :pedidos, unique: false, foreign_key_constraint_name: 'entregas_pedido_id_fk'
      foreign_key :id_repartidor, :repartidores, unique: false, foreign_key_constraint_name: 'entregas_repartidor_id_fk'
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:entregas)
  end
end
