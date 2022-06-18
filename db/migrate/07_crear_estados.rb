Sequel.migration do
  up do
    create_table(:estados) do
      primary_key :id
      String :descripcion
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:estados)
  end
end
