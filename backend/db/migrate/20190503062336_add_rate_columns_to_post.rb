ROM::SQL.migration do
  up do
    alter_table :posts do
      add_column :rate_sum, Numeric, default: 0.0
      add_column :rate_count, Numeric, default: 0, index: true
    end
  end

  down do
    alter_table :posts do
      drop_column :rate_sum
      drop_column :rate_count
    end
  end
end
