task({:test => :environment}) do
  new_customers = CSV.read('lib/tasks/f_accounts2.csv', { :col_sep => ';' })
  CSV.foreach('lib/tasks/f_accounts2.csv', { :col_sep => ';' }) { |row| 

  a = FinancialComponentAccount.new
  a.fc_account_group = row[2]
  a.fc_account_name = row[5]
  a.fc_account_number = row[1]
  a.fc_account_reporting_group = row[3]
  if row[4] == "debit"
    a.fc_account_type = true
  else 
    a.fc_account_type = false
  end
  a.fc_statement = row[0]
  #p row[0] =
  a.save
}
end