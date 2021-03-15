class FinancialComponentTransactionsController < ApplicationController
  def index
    matching_financial_component_transactions = FinancialComponentTransaction.all

    @list_of_financial_component_transactions = matching_financial_component_transactions.order({ :created_at => :desc })

    render({ :template => "financial_component_transactions/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_financial_component_transactions = FinancialComponentTransaction.where({ :id => the_id })

    @the_financial_component_transaction = matching_financial_component_transactions.at(0)

    render({ :template => "financial_component_transactions/show.html.erb" })
  end

  def create
    the_financial_component_transaction = FinancialComponentTransaction.new
    the_financial_component_transaction.plaid_transaction_id = params.fetch("query_plaid_transaction_id")
    the_financial_component_transaction.fc_split_id = params.fetch("query_fc_split_id")
    the_financial_component_transaction.fc_amount = params.fetch("query_fc_amount")
    the_financial_component_transaction.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_transaction.fc_transaction_type = params.fetch("query_fc_transaction_type", false)
    the_financial_component_transaction.fc_commit = params.fetch("query_fc_commit", false)

    if the_financial_component_transaction.valid?
      the_financial_component_transaction.save
      redirect_to("/financial_component_transactions", { :notice => "Financial component transaction created successfully." })
    else
      redirect_to("/financial_component_transactions", { :notice => "Financial component transaction failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_financial_component_transaction = FinancialComponentTransaction.where({ :id => the_id }).at(0)

    the_financial_component_transaction.plaid_transaction_id = params.fetch("query_plaid_transaction_id")
    the_financial_component_transaction.fc_split_id = params.fetch("query_fc_split_id")
    the_financial_component_transaction.fc_amount = params.fetch("query_fc_amount")
    the_financial_component_transaction.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_transaction.fc_transaction_type = params.fetch("query_fc_transaction_type", false)
    the_financial_component_transaction.fc_commit = params.fetch("query_fc_commit", false)

    if the_financial_component_transaction.valid?
      the_financial_component_transaction.save
      redirect_to("/financial_component_transactions/#{the_financial_component_transaction.id}", { :notice => "Financial component transaction updated successfully."} )
    else
      redirect_to("/financial_component_transactions/#{the_financial_component_transaction.id}", { :alert => "Financial component transaction failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_financial_component_transaction = FinancialComponentTransaction.where({ :id => the_id }).at(0)

    the_financial_component_transaction.destroy

    redirect_to("/financial_component_transactions", { :notice => "Financial component transaction deleted successfully."} )
  end
end
