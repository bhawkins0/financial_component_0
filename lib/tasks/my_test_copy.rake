task({:test_2 => :environment}) do
  matching_accounts = FinancialComponentAccount.where(:fc_account_name => FinancialComponentAccount.where.not(:fc_account_reporting_group => nil).map_relation_to_array(:fc_account_reporting_group)).distinct.map_relation_to_array(:fc_account_name)

  p matching_accounts
end