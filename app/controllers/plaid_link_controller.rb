class PlaidLinkController < ApplicationController

  def plaid_index
    #@the_user = User.where(:id => @current_user).at(0)
    render("plaid_views/plaid.html.erb")
  end

#API ENDPOINTS
  def create_link_token
    #USER DETAILS PRE-POPULATED FOR TESTING
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])
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
      country_codes: ['US'],
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
  end

  def get_access_token()
    #@the_user = User.where(:id => @current_user).at(0)
    institution = params.fetch("institution_id")
    the_institution = @current_user.institutions.where(:plaid_institution_id => institution).at(0)
    if the_institution == nil
      get_institution(institution)
    end

    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])    
    
    public_token = params.fetch("public_token")
    response = client.item.public_token.exchange(public_token)
    access_token = response.access_token
    
    #session[:access_token] = access_token

    if cookies["#{the_institution.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"] != nil
      cookies.delete "#{the_institution.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"
    end

    cookies["#{the_institution.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"] = access_token

    #return access_token
  end

  def get_institution(institution)
    client = Plaid::Client.new(env: 'sandbox',
      client_id: ENV['PLAID_CLIENT_ID'],
      secret: ENV['PLAID_SECRET'])

    response = client.institutions.get_by_id(institution, ['US'],options:{include_optional_metadata: TRUE})

    inst = PlaidInstitution.new
    inst.plaid_institution_id = response.fetch("institution").fetch("institution_id")
    inst.plaid_name = response.fetch("institution").fetch("name")
    inst.plaid_logo = response.fetch("institution").fetch("logo")
    inst.fc_user_id = @current_user.id

    save_status = inst.save
  end
end
