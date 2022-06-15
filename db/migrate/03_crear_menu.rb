Sequel.migration do
  up do
    create_table(:menu) do
      primary_key :id
      String :descripcion
      Float :precio
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:menu)
  end
end
