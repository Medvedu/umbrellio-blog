ROM::SQL.migration do
  up do
    create_table :rates do
      primary_key :id, index: true

      column :rate, Integer

      foreign_key :post_id, :posts, index: true
      # foreign_key :user_id, :users, index: true
    end
  end

  down do
    drop_table :rates
  end
end
