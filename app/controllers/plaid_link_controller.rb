
class PlaidLinkController < ApplicationController
  def index
    client = Plaid::Client.new(env: 'sandbox',
      client_id: '5eb39ba40b2dcc00124d076f',  
      secret: '8405e8cc1b8fcc62af5b3fc1819ebc')
      #client_id: ENV['PLAID_CLIENT_ID'],
      #secret: ENV['PLAID_SECRET'])

    create_response = client.sandbox.sandbox_public_token.create(
      institution_id: SANDBOX_INSTITUTION,
      initial_products: ['transactions']
    )

    # The generated public_token can now be
    # exchanged for an access_token
    publicToken = response.public_token
    exchange_token_response = client.item.public_token.exchange(publicToken)

    @access_token = exchange_token_response.fetch("access_token")

    render("/index.html.erb")
  end
end
