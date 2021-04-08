class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie, :process_login_form, :about, :contact] })

  def process_login_form
    a = params.fetch("commit")
    b = params.fetch("userauthentication").fetch("query_email")
    c = params.fetch("userauthentication").fetch("query_password")
    if a == "Log In"
      create_cookie(b,c)
    else
      redirect_to("/sign_up")
    end
  end

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie(uname,pwd)
    #user = User.where({ :email => params.fetch("query_email") }).first
    user = User.where({ :email => uname }).first
    
    #the_supplied_password = params.fetch("query_password")
    the_supplied_password = pwd
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
        
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    @matching_institutions.each do |inst|
    if cookies["#{inst.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}"] != nil
      cookies.delete("#{inst.plaid_name.gsub(/[`~!@#$%^&*()|+\-=?;:'",.<>\{\}\[\]\\\/\s]/,'_')}")
    end
  end

    reset_session

    redirect_to("/sign_in", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("userauthentication").fetch("query_email")
    @user.password = params.fetch("userauthentication").fetch("query_password")
    @user.password_confirmation = params.fetch("userauthentication").fetch("query_password_confirmation")
    @user.first_name = params.fetch("userauthentication").fetch("query_first_name")
    @user.last_name = params.fetch("userauthentication").fetch("query_last_name")

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/", { :notice => "User account created successfully."})
    else
      redirect_to("/sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end
 
  def get_user_profile
    render({ :template => "user_authentication/user_settings.html.erb" })
  end

  def add_mobile
    render({ :template => "user_authentication/add_mobile.html.erb" })
  end

  def validate_mobile
    #twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    #twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
    #twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")
    #twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
    
    #sms_parameters = {
    #  :from => twilio_sending_number,
    #  :to => params.fetch("recipient") # Put your own phone number here if you want to see it in action
    #  :body => "Your verification Code is"
    #}

    #twilio_client.api.account.messages.create(sms_parameters)

  end

end
