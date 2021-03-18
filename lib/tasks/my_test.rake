task({:test => :environment}) do
  test_trans = PlaidTransaction.all.sample
  #p test_trans
  a = test_trans[:plaid_name].to_s
  a = a.gsub(/[0-9]/i,'')

  sql = "SELECT * FROM plaid_transactions WHERE REGEXP_REPLACE(plaid_name,'[[:digit:]]','','g') = '#{a}';"
  p sql
  records_array = ActiveRecord::Base.connection.exec_query(sql)

  #matching_metadata = PlaidTransaction.where("plaid_name REGEXP ?" , '/[^a-z ]/i' => test_trans[:plaid_name].gsub(/[^a-z ]/i,''))
  p records_array
end