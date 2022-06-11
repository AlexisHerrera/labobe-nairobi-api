Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :name
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:users)
  end
end
