Sequel.migration do
  up do
    alter_table(:pedidos) do
      add_foreign_key :id_repartidor, :repartidores, foreign_key_constraint_name: :pedidos_repartidor_fkey
    end
  end

  down do
    alter_table(:pedidos) do
      drop_foreign_key :id_repartidor
    end
  end
end
