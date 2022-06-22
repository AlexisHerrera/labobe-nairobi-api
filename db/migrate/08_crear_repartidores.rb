Sequel.migration do
  up do
    create_table(:repartidores) do
      primary_key :id
      String :nombre
      String :dni
      String :telefono
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:repartidores)
  end
end
