Sequel.migration do
  up do
    add_column :usuarios, :id_telegram, String
  end

  down do
    drop_column :usuarios, :id_telegram
  end
end
