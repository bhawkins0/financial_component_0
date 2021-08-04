class FinancialComponentTransactionSplitsController < ApplicationController
  def index
    matching_financial_component_transaction_splits = FinancialComponentTransactionSplit.all

    @list_of_financial_component_transaction_splits = matching_financial_component_transaction_splits.order({ :created_at => :desc })

    render({ :template => "financial_component_transaction_splits/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_financial_component_transaction_splits = FinancialComponentTransactionSplit.where({ :id => the_id })

    @the_financial_component_transaction_split = matching_financial_component_transaction_splits.at(0)

    render({ :template => "financial_component_transaction_splits/show.html.erb" })
  end

  def create
    the_financial_component_transaction_split = FinancialComponentTransactionSplit.new
    the_financial_component_transaction_split.plaid_transaction_id = params.fetch("query_plaid_transaction_id")
    the_financial_component_transaction_split.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_transaction_split.fc_transaction_split_template_id = params.fetch("query_fc_transaction_split_template_id")
    the_financial_component_transaction_split.fc_amount = params.fetch("query_fc_amount")
    the_financial_component_transaction_split.fc_transaction_split_type = params.fetch("query_fc_transaction_split_type", false)

    if the_financial_component_transaction_split.valid?
      the_financial_component_transaction_split.save
      redirect_to("/financial_component_transaction_splits", { :notice => "Financial component transaction split created successfully." })
    else
      redirect_to("/financial_component_transaction_splits", { :notice => "Financial component transaction split failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_financial_component_transaction_split = FinancialComponentTransactionSplit.where({ :id => the_id }).at(0)

    the_financial_component_transaction_split.plaid_transaction_id = params.fetch("query_plaid_transaction_id")
    the_financial_component_transaction_split.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_transaction_split.fc_transaction_split_template_id = params.fetch("query_fc_transaction_split_template_id")
    the_financial_component_transaction_split.fc_amount = params.fetch("query_fc_amount")
    the_financial_component_transaction_split.fc_transaction_split_type = params.fetch("query_fc_transaction_split_type", false)

    if the_financial_component_transaction_split.valid?
      the_financial_component_transaction_split.save
      redirect_to("/financial_component_transaction_splits/#{the_financial_component_transaction_split.id}", { :notice => "Financial component transaction split updated successfully."} )
    else
      redirect_to("/financial_component_transaction_splits/#{the_financial_component_transaction_split.id}", { :alert => "Financial component transaction split failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_financial_component_transaction_split = FinancialComponentTransactionSplit.where({ :id => the_id }).at(0)

    the_financial_component_transaction_split.destroy

    redirect_to("/financial_component_transaction_splits", { :notice => "Financial component transaction split deleted successfully."} )
  end
end
