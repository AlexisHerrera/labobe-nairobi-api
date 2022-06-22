Sequel.migration do
  up do
    create_table(:repartidores) do
      primary_key :id
      String :nombre
      String :dni
      String :telefono
      Date :created_on
      Date :updated_on
      # No solo se verifica en el modelo, sino tambien en la BD :)
      index :telefono, unique: true
    end
  end

  down do
    drop_table(:repartidores)
  end
end
