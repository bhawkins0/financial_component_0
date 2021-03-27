class PlaidLinkController < ApplicationController

  def plaid_index
    #@the_user = User.where(:id => @current_user).at(0)
    render("plaid_views/plaid.html.erb")
  end

#API ENDPOINTS
  def create_link_token
    #USER DETAILS PRE-POPULATED FOR TESTING
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])
    response = client.link_token.create(
      user: {
        client_user_id: @current_user.to_s,
        legal_name: "John Doe",
        phone_number: "+1 415 555 0123",
        phone_number_verified_time: "2020-01-01T00:00:00Z",
        email_address: "example@plaid.com"
      },
      client_name: 'Plaid Test App',
      products: %w[auth transactions],
      country_codes: ['US'],
      language: 'en',
      #webhook: 'https://sample-webhook.com',
      #link_customization_name: 'default',
      account_filters: {
        depository: {
          account_subtypes: %w[checking savings]
          }
      }
    )
    
    render :json => response
  end

  def get_access_token()
    #@the_user = User.where(:id => @current_user).at(0)
    institution = params.fetch("institution_id")
    the_institution = @current_user.plaid_institutions.where(:plaid_institution_id => institution).at(0)
    
    if the_institution == nil
      save_institution(institution)
      the_institution = @current_user.plaid_institutions.where(:plaid_institution_id => institution).at(0)
    end

    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])    
    
    public_token = params.fetch("public_token")
    response = client.item.public_token.exchange(public_token)
    access_token = response.access_token
    
    #session[:access_token] = access_token

    if cookies["#{the_institution.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"] != nil
      cookies.delete "#{the_institution.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"
    end

    cookies["#{the_institution.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"] = access_token

    #return access_token
  end

  def save_institution(institution)
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

    response = client.institutions.get_by_id(institution, ['US'],options:{include_optional_metadata: TRUE})

    inst = PlaidInstitution.new
    inst.plaid_institution_id = response.fetch("institution").fetch("institution_id")
    inst.plaid_name = response.fetch("institution").fetch("name")
    inst.plaid_logo = response.fetch("institution").fetch("logo")
    inst.fc_user_id = @current_user.id

    save_status = inst.save
  end

  def get_transactions
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

    access_token = cookies["#{params.fetch("institution_name").gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"]
    matching_accounts = PlaidAccount.where(:fc_user_id => @current_user.id).map_relation_to_array(:plaid_account_id)

    d = Date.today
    d2 = PlaidTransaction.where(:plaid_account_id => matching_accounts).maximum(:plaid_date)
    
    if d2 == nil
      d2 = d << 24
    end

    response = client.transactions.get(access_token,
                                        d2.strftime("%Y-%m-%d"),
                                        d.strftime("%Y-%m-%d"))
    accounts = response['accounts']
    transactions = response['transactions']

    # Manipulate the offset parameter to paginate transactions
    # and retrieve all available data
    
    while transactions.length() < response['total_transactions']
      response = client.transactions.get(access_token,
                                          d2.strftime("%Y-%m-%d"),
                                          d.strftime("%Y-%m-%d"),
          offset: transactions.length())
      #COMMENTED OUT FOR TESTING PURPOSES - UNCOMMENT
      #accounts += response['accounts']
      #transactions += response['transactions']
    end

    accounts.each do |acct|
      if PlaidAccount.where(:plaid_account_id => acct['account_id']).at(0) == nil
        the_plaid_account = PlaidAccount.new
        the_plaid_account.plaid_institution_id = PlaidInstitution.where(:plaid_name => params.fetch("institution_name")).at(0).plaid_institution_id
        the_plaid_account.plaid_account_id = acct[:account_id]
        the_plaid_account.plaid_account_name = acct[:name]
        the_plaid_account.plaid_account_type = acct[:type]
        the_plaid_account.fc_user_id = @current_user.id
        
        if ['depository','investment'].include? acct[:type]
          the_plaid_account.fc_account_normal_balance = 'debit'
        else
          the_plaid_account.fc_account_normal_balance = 'credit'
        end

        if the_plaid_account.valid?
          the_plaid_account.save
        end
      end
    end
    
    #p "TRANSACTIONS2:"
    #p transactions
    transactions.each do |trans|
      location = trans[:location]
      if PlaidTransaction.where(:plaid_transaction_id	 => trans['transaction_id']).at(0) == nil
        the_plaid_transaction = PlaidTransaction.new
        the_plaid_transaction.plaid_account_id = trans[:account_id]
        if trans[:authorized_date] == nil
          the_plaid_transaction.plaid_authorized_date = trans[:date]
        else
          the_plaid_transaction.plaid_authorized_date = trans[:authorized_date]
        end
        the_plaid_transaction.plaid_date = trans[:date]
        the_plaid_transaction.plaid_name = trans[:name]
        the_plaid_transaction.plaid_amount = trans[:amount]
        the_plaid_transaction.plaid_iso_currency_code = trans[:iso_currency_code]
        the_plaid_transaction.plaid_category = trans[:category]
        the_plaid_transaction.plaid_merchant_name = trans[:merchant_name]
        the_plaid_transaction.plaid_address = location[:address]
        the_plaid_transaction.plaid_city = location[:city]
        the_plaid_transaction.plaid_region = location[:region]
        the_plaid_transaction.plaid_postal_code = location[:postal_code]
        the_plaid_transaction.plaid_country = location[:country]
        the_plaid_transaction.plaid_latitude = location[:lat]
        the_plaid_transaction.plaid_longitude = location[:lon]
        the_plaid_transaction.plaid_transaction_id = trans[:transaction_id]
        
        if the_plaid_transaction.valid?
          the_plaid_transaction.save
        end

        the_financial_component_transaction_1 = FinancialComponentTransaction.new
        the_financial_component_transaction_2 = FinancialComponentTransaction.new

        the_financial_component_transaction_1.plaid_transaction_id = trans[:transaction_id]
        the_financial_component_transaction_2.plaid_transaction_id = trans[:transaction_id]

        the_financial_component_transaction_1.fc_transaction_id = 1
        the_financial_component_transaction_2.fc_transaction_id = 2

        the_financial_component_transaction_1.fc_amount = trans[:amount]
        the_financial_component_transaction_2.fc_amount = trans[:amount]
        
        #true = 'debit'
        the_financial_component_transaction_1.fc_transaction_type = true
        the_financial_component_transaction_2.fc_transaction_type = false

        the_financial_component_transaction_1.fc_commit = false
        the_financial_component_transaction_2.fc_commit = false
        
        #Identify Matching Metadata
        trans_name = trans[:name].to_s.gsub(/[^a-z ]/i,'')
        trans_merchant = trans[:merchant_name].to_s.gsub(/[^a-z ]/i,'')
        trans_category = trans[:category].to_s.gsub(/[^a-z ]/i,'')

        matching_metadata_1 = FinancialComponentKeyword.where(:plaid_name	=> trans_name).order({ :transaction_count => :desc }).at(0)
        matching_metadata_2 = FinancialComponentKeyword.where({:plaid_merchant_name	=> trans_merchant,:plaid_category	=> trans_category }).order({ :transaction_count => :desc }).at(0)
        matching_metadata_3 = FinancialComponentKeyword.where(:plaid_category	=> trans_category).order({ :transaction_count => :desc }).at(0)

        if matching_metadata_1 != nil 
          the_financial_component_transaction_1.fc_split_id = matching_metadata_1[:fc_split_id]
          the_financial_component_transaction_2.fc_split_id = matching_metadata_1[:fc_split_id]

          the_financial_component_transaction_1.fc_account_number = matching_metadata_1[:fc_debit]
          the_financial_component_transaction_2.fc_account_number = matching_metadata_1[:fc_credit]
        elsif matching_metadata_2 != nil
          the_financial_component_transaction_1.fc_split_id = matching_metadata_2[:fc_split_id]
          the_financial_component_transaction_2.fc_split_id = matching_metadata_2[:fc_split_id]

          the_financial_component_transaction_1.fc_account_number = matching_metadata_2[:fc_debit]
          the_financial_component_transaction_2.fc_account_number = matching_metadata_2[:fc_credit]
        elsif matching_metadata_3 != nil
          the_financial_component_transaction_1.fc_split_id = matching_metadata_3[:fc_split_id]
          the_financial_component_transaction_2.fc_split_id = matching_metadata_3[:fc_split_id]

          the_financial_component_transaction_1.fc_account_number = matching_metadata_3[:fc_debit]
          the_financial_component_transaction_2.fc_account_number = matching_metadata_3[:fc_credit]
        else
          the_financial_component_transaction_1.fc_split_id = 0
          the_financial_component_transaction_2.fc_split_id = 0

          the_financial_component_transaction_1.fc_account_number = 0
          the_financial_component_transaction_2.fc_account_number = 0
        end

        if the_financial_component_transaction_1.valid?
          the_financial_component_transaction_1.save
        end
        if the_financial_component_transaction_2.valid?
          the_financial_component_transaction_2.save
        end
      end
    end
  end

  def get_institution
    @matching_transactions = FinancialComponentTransaction.joins(plaid_transaction: [plaid_account: [plaid_institution: [:user]]]).where(:users => {:id => @current_user.id}).where(:plaid_institutions => {:plaid_name => params.fetch("the_institution")}).where(:fc_commit => false).order(:plaid_account_name).order({ :plaid_authorized_date => :desc }).order(:plaid_transaction_id).order(:fc_transaction_id)
    @matching_accounts = FinancialComponentAccount.where(:fc_account_name => FinancialComponentAccount.where.not(:fc_account_reporting_group => nil).map_relation_to_array(:fc_account_reporting_group)).distinct.map_relation_to_array(:fc_account_name)
    render("plaid_views/plaid_institution.html.erb")
  end

  def save_account
    acct_name = params.fetch("acct_name");
    trans_id = params.fetch("trans_id");
    trans_type = params.fetch("trans_type").to_i;

    the_account = FinancialComponentAccount.where(:fc_account_name => acct_name).at(0)
    
    if trans_type == 1
      the_transaction = FinancialComponentTransaction.where({:plaid_transaction_id => trans_id,:fc_transaction_type => 1}).at(0)
    else
      the_transaction = FinancialComponentTransaction.where({:plaid_transaction_id => trans_id,:fc_transaction_type => 0}).at(0)
    end

    the_transaction.fc_account_number = the_account.fc_account_number
    if the_transaction.valid?
      the_transaction.save
    end
  end

  def commit_audit
    @matching_transactions = FinancialComponentTransaction.joins(plaid_transaction: [plaid_account: [plaid_institution: [:user]]]).where(:users => {:id => @current_user.id}).where(:plaid_institutions => {:plaid_name => params.fetch("the_institution")}).where(:fc_commit => false).order(:plaid_account_name).order({ :plaid_authorized_date => :desc }).order(:plaid_transaction_id).order(:fc_transaction_id)
    i = 0
    trans_debit = FinancialComponentTransaction.new
    trans_credit = FinancialComponentTransaction.new
    @matching_transactions.each do |trans|

      if trans.fc_transaction_type == true
        trans_debit = trans
      else
        trans_credit = trans
        if trans_debit.fc_account_number != 0 and trans_credit.fc_account_number != 0 and trans_debit.valid? and trans_credit.valid?
          trans_debit.fc_commit = true
          trans_credit.fc_commit = true

          trans_debit.save
          trans_credit.save

          i = i + 1
        end
      end
    end
      render :json => i
  end
end
