class PlaidAccountsController < ApplicationController
  def index
    matching_plaid_accounts = PlaidAccount.all

    @list_of_plaid_accounts = matching_plaid_accounts.order({ :created_at => :desc })

    render({ :template => "plaid_accounts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_plaid_accounts = PlaidAccount.where({ :id => the_id })

    @the_plaid_account = matching_plaid_accounts.at(0)

    render({ :template => "plaid_accounts/show.html.erb" })
  end

  def create
    the_plaid_account = PlaidAccount.new
    the_plaid_account.plaid_institution_id = params.fetch("query_plaid_institution_id")
    the_plaid_account.plaid_account_id = params.fetch("query_plaid_account_id")
    the_plaid_account.plaid_account_name = params.fetch("query_plaid_account_name")
    the_plaid_account.plaid_account_type = params.fetch("query_plaid_account_type")
    the_plaid_account.fc_account_normal_balance = params.fetch("query_fc_account_normal_balance")

    if the_plaid_account.valid?
      the_plaid_account.save
      redirect_to("/plaid_accounts", { :notice => "Plaid account created successfully." })
    else
      redirect_to("/plaid_accounts", { :notice => "Plaid account failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plaid_account = PlaidAccount.where({ :id => the_id }).at(0)

    the_plaid_account.plaid_institution_id = params.fetch("query_plaid_institution_id")
    the_plaid_account.plaid_account_id = params.fetch("query_plaid_account_id")
    the_plaid_account.plaid_account_name = params.fetch("query_plaid_account_name")
    the_plaid_account.plaid_account_type = params.fetch("query_plaid_account_type")
    the_plaid_account.fc_account_normal_balance = params.fetch("query_fc_account_normal_balance")

    if the_plaid_account.valid?
      the_plaid_account.save
      redirect_to("/plaid_accounts/#{the_plaid_account.id}", { :notice => "Plaid account updated successfully."} )
    else
      redirect_to("/plaid_accounts/#{the_plaid_account.id}", { :alert => "Plaid account failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plaid_account = PlaidAccount.where({ :id => the_id }).at(0)

    the_plaid_account.destroy

    redirect_to("/plaid_accounts", { :notice => "Plaid account deleted successfully."} )
  end
end
