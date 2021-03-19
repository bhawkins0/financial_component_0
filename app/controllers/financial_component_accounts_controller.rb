class FinancialComponentAccountsController < ApplicationController
  def index
    matching_financial_component_accounts = FinancialComponentAccount.all

    @list_of_financial_component_accounts = matching_financial_component_accounts.order({ :created_at => :desc })

    render({ :template => "financial_component_accounts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_financial_component_accounts = FinancialComponentAccount.where({ :id => the_id })

    @the_financial_component_account = matching_financial_component_accounts.at(0)

    render({ :template => "financial_component_accounts/show.html.erb" })
  end

  def create
    the_financial_component_account = FinancialComponentAccount.new
    the_financial_component_account.fc_statement = params.fetch("query_fc_statement")
    the_financial_component_account.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_account.fc_account_group = params.fetch("query_fc_account_group")
    the_financial_component_account.fc_account_reporting_group = params.fetch("query_fc_account_reporting_group")
    the_financial_component_account.fc_account_type = params.fetch("query_fc_account_type", false)
    the_financial_component_account.fc_account_name = params.fetch("query_fc_account_name")

    if the_financial_component_account.valid?
      the_financial_component_account.save
      redirect_to("/financial_component_accounts", { :notice => "Financial component account created successfully." })
    else
      redirect_to("/financial_component_accounts", { :notice => "Financial component account failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_financial_component_account = FinancialComponentAccount.where({ :id => the_id }).at(0)

    the_financial_component_account.fc_statement = params.fetch("query_fc_statement")
    the_financial_component_account.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_account.fc_account_group = params.fetch("query_fc_account_group")
    the_financial_component_account.fc_account_reporting_group = params.fetch("query_fc_account_reporting_group")
    the_financial_component_account.fc_account_type = params.fetch("query_fc_account_type", false)
    the_financial_component_account.fc_account_name = params.fetch("query_fc_account_name")

    if the_financial_component_account.valid?
      the_financial_component_account.save
      redirect_to("/financial_component_accounts/#{the_financial_component_account.id}", { :notice => "Financial component account updated successfully."} )
    else
      redirect_to("/financial_component_accounts/#{the_financial_component_account.id}", { :alert => "Financial component account failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_financial_component_account = FinancialComponentAccount.where({ :id => the_id }).at(0)

    the_financial_component_account.destroy

    redirect_to("/financial_component_accounts", { :notice => "Financial component account deleted successfully."} )
  end
end
