
class PlaidLinkController < ApplicationController
  def index
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

    #USER DETAILS PRE-POPULATED FOR TESTING
    link_token_response = client.link_token.create(
    user: {
      client_user_id: @current_user.to_s,
      legal_name: "John Doe",
      phone_number: "+1 415 555 0123",
      phone_number_verified_time: "2020-01-01T00:00:00Z",
      email_address: "example@plaid.com"
    },
    client_name: 'Plaid Test App',
    products: %w[auth transactions],
    country_codes: ['GB'],
    language: 'en',
    #webhook: 'https://sample-webhook.com',
    #link_customization_name: 'default',
    account_filters: {
      depository: {
        account_subtypes: %w[checking savings]
      }
    }
  )
  @link_token = link_token_response.link_token

    #TESTING
    #create_response = client.sandbox.sandbox_public_token.create(
    #  institution_id: "ins_1",
    #  initial_products: ['transactions']
    #)

    # The generated public_token can now be
    # exchanged for an access_token
    #publicToken = create_response.public_token
    #exchange_token_response = client.item.public_token.exchange(publicToken)

    #access_token = exchange_token_response.fetch("access_token")

    #session[:access_token] = access_token

    render("/index.html.erb")
  end

  #API ENDPOINTS
  def get_access_token()
     client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])
      
    public_token = params.fetch("public_token")
    response = client.item.public_token.exchange(public_token)
    access_token = response.access_token
    
    session[:access_token] = access_token
    return access_token
  end
end
