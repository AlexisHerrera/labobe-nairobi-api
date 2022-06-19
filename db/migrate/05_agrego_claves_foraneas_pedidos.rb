Sequel.migration do
  up do
    drop_table(:pedidos)
    create_table(:pedidos) do
      primary_key :id
      foreign_key :id_usuario, :usuarios, unique: false, foreign_key_constraint_name: 'pedidos_usuario_id_fk'
      foreign_key :id_menu, :menu, unique: false, foreign_key_constraint_name: 'pedidos_menu_id_fk'
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:pedidos)
    create_table(:pedidos) do
      primary_key :id
      String :id_usuario
      Int :id_menu
      Date :created_on
      Date :updated_on
    end
  end
end
