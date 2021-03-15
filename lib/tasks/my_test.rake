task({:test => :environment}) do
  db_connection = ActiveRecord::Base.connection.raw_connection
  db_connection.transaction do
    db_connection.execute(%{
      CREATE TEMP TABLE selected_accounts (
        SELECT "TEST" AS N;
      )
      ON COMMIT DROP;
    })
    records_array = db_connection.execute(%{
      SELECT * FROM selected_accounts
    })
    #records_array = ActiveRecord::Base.connection.execute(sql)
    #records_array = execute_statement(sql)
  end
  p records_array
end