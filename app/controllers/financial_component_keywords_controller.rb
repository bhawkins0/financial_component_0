class FinancialComponentKeywordsController < ApplicationController
  def index
    matching_financial_component_keywords = FinancialComponentKeyword.all

    @list_of_financial_component_keywords = matching_financial_component_keywords.order({ :created_at => :desc })

    render({ :template => "financial_component_keywords/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_financial_component_keywords = FinancialComponentKeyword.where({ :id => the_id })

    @the_financial_component_keyword = matching_financial_component_keywords.at(0)

    render({ :template => "financial_component_keywords/show.html.erb" })
  end

  def create
    the_financial_component_keyword = FinancialComponentKeyword.new
    the_financial_component_keyword.plaid_name = params.fetch("query_plaid_name")
    the_financial_component_keyword.plaid_merchant_name = params.fetch("query_plaid_merchant_name")
    the_financial_component_keyword.plaid_category = params.fetch("query_plaid_category")
    the_financial_component_keyword.fc_split_id = params.fetch("query_fc_split_id")
    the_financial_component_keyword.transaction_cont = params.fetch("query_transaction_cont")

    if the_financial_component_keyword.valid?
      the_financial_component_keyword.save
      redirect_to("/financial_component_keywords", { :notice => "Financial component keyword created successfully." })
    else
      redirect_to("/financial_component_keywords", { :notice => "Financial component keyword failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_financial_component_keyword = FinancialComponentKeyword.where({ :id => the_id }).at(0)

    the_financial_component_keyword.plaid_name = params.fetch("query_plaid_name")
    the_financial_component_keyword.plaid_merchant_name = params.fetch("query_plaid_merchant_name")
    the_financial_component_keyword.plaid_category = params.fetch("query_plaid_category")
    the_financial_component_keyword.fc_split_id = params.fetch("query_fc_split_id")
    the_financial_component_keyword.transaction_cont = params.fetch("query_transaction_cont")

    if the_financial_component_keyword.valid?
      the_financial_component_keyword.save
      redirect_to("/financial_component_keywords/#{the_financial_component_keyword.id}", { :notice => "Financial component keyword updated successfully."} )
    else
      redirect_to("/financial_component_keywords/#{the_financial_component_keyword.id}", { :alert => "Financial component keyword failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_financial_component_keyword = FinancialComponentKeyword.where({ :id => the_id }).at(0)

    the_financial_component_keyword.destroy

    redirect_to("/financial_component_keywords", { :notice => "Financial component keyword deleted successfully."} )
  end
end
