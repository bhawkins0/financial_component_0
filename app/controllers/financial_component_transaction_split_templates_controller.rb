class FinancialComponentTransactionSplitTemplatesController < ApplicationController
  def index
    matching_financial_component_transaction_split_templates = FinancialComponentTransactionSplitTemplate.all

    @list_of_financial_component_transaction_split_templates = matching_financial_component_transaction_split_templates.order({ :created_at => :desc })

    render({ :template => "financial_component_transaction_split_templates/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_financial_component_transaction_split_templates = FinancialComponentTransactionSplitTemplate.where({ :id => the_id })

    @the_financial_component_transaction_split_template = matching_financial_component_transaction_split_templates.at(0)

    render({ :template => "financial_component_transaction_split_templates/show.html.erb" })
  end

  def create
    the_financial_component_transaction_split_template = FinancialComponentTransactionSplitTemplate.new
    the_financial_component_transaction_split_template.fc_transaction_split_template_name = params.fetch("query_fc_transaction_split_template_name")
    the_financial_component_transaction_split_template.fc_transaction_split_percent = params.fetch("query_fc_transaction_split_percent")
    the_financial_component_transaction_split_template.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_transaction_split_template.fc_transaction_split_type = params.fetch("query_fc_transaction_split_type", false)

    if the_financial_component_transaction_split_template.valid?
      the_financial_component_transaction_split_template.save
      redirect_to("/financial_component_transaction_split_templates", { :notice => "Financial component transaction split template created successfully." })
    else
      redirect_to("/financial_component_transaction_split_templates", { :notice => "Financial component transaction split template failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_financial_component_transaction_split_template = FinancialComponentTransactionSplitTemplate.where({ :id => the_id }).at(0)

    the_financial_component_transaction_split_template.fc_transaction_split_template_name = params.fetch("query_fc_transaction_split_template_name")
    the_financial_component_transaction_split_template.fc_transaction_split_percent = params.fetch("query_fc_transaction_split_percent")
    the_financial_component_transaction_split_template.fc_account_number = params.fetch("query_fc_account_number")
    the_financial_component_transaction_split_template.fc_transaction_split_type = params.fetch("query_fc_transaction_split_type", false)

    if the_financial_component_transaction_split_template.valid?
      the_financial_component_transaction_split_template.save
      redirect_to("/financial_component_transaction_split_templates/#{the_financial_component_transaction_split_template.id}", { :notice => "Financial component transaction split template updated successfully."} )
    else
      redirect_to("/financial_component_transaction_split_templates/#{the_financial_component_transaction_split_template.id}", { :alert => "Financial component transaction split template failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_financial_component_transaction_split_template = FinancialComponentTransactionSplitTemplate.where({ :id => the_id }).at(0)

    the_financial_component_transaction_split_template.destroy

    redirect_to("/financial_component_transaction_split_templates", { :notice => "Financial component transaction split template deleted successfully."} )
  end
end
