
class PlaidLinkController < ApplicationController
  def index
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

    create_response = client.sandbox.sandbox_public_token.create(
      institution_id: "ins_1",
      initial_products: ['transactions']
    )

    # The generated public_token can now be
    # exchanged for an access_token
    publicToken = create_response.public_token
    exchange_token_response = client.item.public_token.exchange(publicToken)

    @access_token = exchange_token_response.fetch("access_token")

    render("/index.html.erb")
  end
end
