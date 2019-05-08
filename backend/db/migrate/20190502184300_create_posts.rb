require 'rom/sql/type_extensions'

ROM::SQL.migration do
  up do
    create_table :posts do
      primary_key :id, index: true

      column :title, String, null: false, size: 50
      column :author_ip, :inet
      column :body, String

      foreign_key :author_id, :users, index: true
    end
  end

  down do
    drop_table :posts
  end
end
