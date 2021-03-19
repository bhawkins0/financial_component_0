task({:test => :environment}) do
  
  @current_user = User.where({ :id => 1 }).first
   #FinancialComponentTransaction.joins(:plaid_transaction)
  
    #.joins(:plaid_account).where(plaid_accounts:{fc_user_id: @current_user.id})
  #.joins(:plaid_account).where(plaid_accounts:{fc_user_id: @current_user.id})  
    #matching_trans = PlaidTransaction.where(:plaid_transaction_id => matching_transactions.plaid_transaction_id)
    p matching_transactions
    #p matching_trans
end