class PlaidTransactionsController < ApplicationController
  def index
    matching_plaid_transactions = PlaidTransaction.all

    @list_of_plaid_transactions = matching_plaid_transactions.order({ :created_at => :desc })

    render({ :template => "plaid_transactions/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_plaid_transactions = PlaidTransaction.where({ :id => the_id })

    @the_plaid_transaction = matching_plaid_transactions.at(0)

    render({ :template => "plaid_transactions/show.html.erb" })
  end

  def create
    the_plaid_transaction = PlaidTransaction.new
    the_plaid_transaction.plaid_account_id = params.fetch("query_plaid_account_id")
    the_plaid_transaction.plaid_authorized_date = params.fetch("query_plaid_authorized_date")
    the_plaid_transaction.plaid_date = params.fetch("query_plaid_date")
    the_plaid_transaction.plaid_name = params.fetch("query_plaid_name")
    the_plaid_transaction.plaid_amount = params.fetch("query_plaid_amount")
    the_plaid_transaction.plaid_iso_currency_code = params.fetch("query_plaid_iso_currency_code")
    the_plaid_transaction.plaid_category = params.fetch("query_plaid_category")
    the_plaid_transaction.plaid_merchant_name = params.fetch("query_plaid_merchant_name")
    the_plaid_transaction.plaid_address = params.fetch("query_plaid_address")
    the_plaid_transaction.plaid_city = params.fetch("query_plaid_city")
    the_plaid_transaction.plaid_region = params.fetch("query_plaid_region")
    the_plaid_transaction.plaid_postal_code = params.fetch("query_plaid_postal_code")
    the_plaid_transaction.plaid_country = params.fetch("query_plaid_country")
    the_plaid_transaction.plaid_latitude = params.fetch("query_plaid_latitude")
    the_plaid_transaction.plaid_longitude = params.fetch("query_plaid_longitude")
    the_plaid_transaction.plaid_transaction_id = params.fetch("query_plaid_transaction_id")

    if the_plaid_transaction.valid?
      the_plaid_transaction.save
      redirect_to("/plaid_transactions", { :notice => "Plaid transaction created successfully." })
    else
      redirect_to("/plaid_transactions", { :notice => "Plaid transaction failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plaid_transaction = PlaidTransaction.where({ :id => the_id }).at(0)

    the_plaid_transaction.plaid_account_id = params.fetch("query_plaid_account_id")
    the_plaid_transaction.plaid_authorized_date = params.fetch("query_plaid_authorized_date")
    the_plaid_transaction.plaid_date = params.fetch("query_plaid_date")
    the_plaid_transaction.plaid_name = params.fetch("query_plaid_name")
    the_plaid_transaction.plaid_amount = params.fetch("query_plaid_amount")
    the_plaid_transaction.plaid_iso_currency_code = params.fetch("query_plaid_iso_currency_code")
    the_plaid_transaction.plaid_category = params.fetch("query_plaid_category")
    the_plaid_transaction.plaid_merchant_name = params.fetch("query_plaid_merchant_name")
    the_plaid_transaction.plaid_address = params.fetch("query_plaid_address")
    the_plaid_transaction.plaid_city = params.fetch("query_plaid_city")
    the_plaid_transaction.plaid_region = params.fetch("query_plaid_region")
    the_plaid_transaction.plaid_postal_code = params.fetch("query_plaid_postal_code")
    the_plaid_transaction.plaid_country = params.fetch("query_plaid_country")
    the_plaid_transaction.plaid_latitude = params.fetch("query_plaid_latitude")
    the_plaid_transaction.plaid_longitude = params.fetch("query_plaid_longitude")
    the_plaid_transaction.plaid_transaction_id = params.fetch("query_plaid_transaction_id")

    if the_plaid_transaction.valid?
      the_plaid_transaction.save
      redirect_to("/plaid_transactions/#{the_plaid_transaction.id}", { :notice => "Plaid transaction updated successfully."} )
    else
      redirect_to("/plaid_transactions/#{the_plaid_transaction.id}", { :alert => "Plaid transaction failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plaid_transaction = PlaidTransaction.where({ :id => the_id }).at(0)

    the_plaid_transaction.destroy

    redirect_to("/plaid_transactions", { :notice => "Plaid transaction deleted successfully."} )
  end
end
