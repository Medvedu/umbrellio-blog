ROM::SQL.migration do
  up do
    sql_materialized_view = <<~SQL
      CREATE MATERIALIZED VIEW logins_per_uniq_ip
      AS
        SELECT abbrev(author_ip) AS ip, STRING_AGG(DISTINCT users.login, ', ') AS logins
        FROM posts
        JOIN users ON users.id = posts.author_id 
        GROUP BY author_ip
        HAVING COUNT(author_id) > 1
      WITH NO DATA;
    SQL
    execute sql_materialized_view

    sql_add_index_to_materialized_view = <<~SQL
      CREATE UNIQUE INDEX idx_logins_per_uniq_ip ON logins_per_uniq_ip(ip);
    SQL
    execute sql_add_index_to_materialized_view
  end

  down do
    sql_materialized_view = <<~SQL
      DROP MATERIALIZED VIEW logins_per_uniq_ip
    SQL
    execute sql_materialized_view

    sql_remove_index_to_materialized_view = <<~SQL
      DROP INDEX IF EXISTS idx_logins_per_uniq_ip
    SQL
    execute sql_remove_index_to_materialized_view
  end
end
