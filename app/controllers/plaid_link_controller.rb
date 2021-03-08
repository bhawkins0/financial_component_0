
class PlaidLinkController < ApplicationController
  def index
    render("/index.html.erb")
  end

  #API ENDPOINTS
 def create_link_token()
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

         #USER DETAILS PRE-POPULATED FOR TESTING
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
    
    render :json => response
    #return response.to_json
  end

  def get_access_token()      
    public_token = params.fetch("public_token")
    response = client.item.public_token.exchange(public_token)
    access_token = response.access_token
    
    session[:access_token] = access_token
    return access_token
  end
end
