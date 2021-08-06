if Rails.env.development?
  task({:my_dev => :environment}) do

    trans = PlaidTransaction.all.sample
    
    p trans

    trans_name = trans[:plaid_name].to_s.gsub(/[^a-z ]/i,'')
    trans_merchant = trans[:plaid_merchant_name].to_s.gsub(/[^a-z ]/i,'')
    trans_category = trans[:plaid_category]

    matching_metadata_1 = FinancialComponentKeyword.where(:plaid_name	=> trans_name).order({ :transaction_count => :desc }).at(0)
    matching_metadata_2 = FinancialComponentKeyword.where({:plaid_merchant_name	=> trans_merchant,:plaid_category	=> trans_category }).order({ :transaction_count => :desc }).at(0)
    matching_metadata_3 = FinancialComponentKeyword.where(:plaid_category	=> trans_category).order({ :transaction_count => :desc }).at(0)

    p trans_category
    p matching_metadata_1
    p matching_metadata_2
    p matching_metadata_3
  end
end