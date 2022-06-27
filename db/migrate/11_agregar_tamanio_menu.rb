Sequel.migration do
  up do
    add_column :menu, :tamanio, String, default: 'grande'
  end

  down do
    drop_column :menu, :tamanio
  end
end
