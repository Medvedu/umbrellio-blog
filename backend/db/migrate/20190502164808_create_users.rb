ROM::SQL.migration do
  up do
    create_table :users do
      primary_key :id, index: true

      column :login, String, null: false, size: 30, index: true
    end
  end

  down do
    drop_table :users
  end
end
