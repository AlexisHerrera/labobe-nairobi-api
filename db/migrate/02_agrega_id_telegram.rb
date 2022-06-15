Sequel.migration do
  # Hay una columna repetida con datos (id y telefono)
  # Se puede prescindir de ella?
  up do
    add_column :usuarios, :id_telegram, String
  end

  down do
    drop_column :usuarios, :id_telegram
  end
end
