class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_in, :process_login_form, :create_cookie, :sign_up, :create_user, :validate_email, :forgot_password, :password_reset, :reset_password, :email_code, :verify_password] })

  def sign_in
    #render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def process_login_form
    a = params.fetch("subject")
    b = params.fetch("query_email")
    c = params.fetch("query_password")
    if a == "Log In"
      create_cookie(b,c)
    else
      redirect_to("/sign_up")
    end
  end

  def create_cookie(uname,pwd)
    user = User.where({ :email => uname }).first

    the_supplied_password = pwd
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/sign_in", { :alert => "Incorrect login information." })
      else
        if user.password_verified_at == nil
          user = User.where(:email => params.fetch("query_email")).first
          @current_user = user

          session[:user_id] = user.id

          o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
          pwd = (0...16).map { o[rand(o.length)] }.join
          p(pwd)
          user.password = pwd
          user.password_confirmation = pwd
          
          if user.valid?
            user.save
            
            email_code
            render({ :template => "user_authentication/reset_password.html.erb", :locals => {:alert => "Please reset your password to login."}})
          end
        else
          #INSERT MFA CODE HERE
          session[:user_id] = user.id
          
          redirect_to("/index", { :notice => "Signed in successfully." })
        end
      end
    else
      redirect_to("/sign_in", { :alert => "No user with that email address." })
    end
  end

  def sign_up
    #render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create_user()
    if !validate_email
      user = User.new
      user.first_name = params.fetch("query_first_name")
      user.last_name = params.fetch("query_last_name")
      user.password = params.fetch("query_password")
      user.password_confirmation = params.fetch("query_password_confirmation")
      user.password_verified_at = Time.now
      user.email = params.fetch("query_email")
      user.mobile = params.fetch("query_mobile")

      if user.valid?
        user.save
      end

      @user_save_status = user.save

      UserVerification.where(:email => params.fetch("query_email")).destroy_all
      user_verification = UserVerification.new
      user_verification.user_id = user.id
      user_verification.email = params.fetch("query_email")
      user_verification.mobile = params.fetch("query_mobile")

      if user_verification.valid?
        user_verification.save
      end

      @user_verification_save_status = user_verification.save
      
      if @user_save_status == true
        session[:user_id] = user.id
        @current_user = user
      end
    end
    
    respond_to do |format|
      format.js
    end
  end

  def validate_email
    query_email = params.fetch("query_email")

    if ((query_email != '') && (query_email != nil))

      email_exists = User.where({ :email => query_email }).first

      if email_exists == nil
        @email_exists = false
      else 
        @email_exists = true
      end 
    end
    
    #create_user
    return @email_exists
  end

  def get_user_profile
    render({ :template => "user_authentication/user_settings.html.erb" })
  end

  def verify_email
    user_verification = UserVerification.where(:user_id => @current_user.id).first
    user_verification.email_validation_code = rand(1000..9999)
    
    if user_verification.valid?
      user_verification.save

      email_code

      render({ :template => "user_authentication/verify_email.html.erb" })
    else
      redirect_to("/user/settings", { :alert => "Oops! That didn't work! Please try to verify again." })
    end
  end
  
  include SendGrid
  def email_code
    # using SendGrid's Ruby Library
    # https://github.com/sendgrid/sendgrid-ruby
    
    from = Email.new(email: 'brennan@financialcomponent.com')
    to = Email.new(email: @current_user.email)
    if @current_user.password_verified_at == nil
      subject = 'Financial Component Password Reset'
      content = Content.new(type: 'text/plain', value: 'Please see below for a validation code to reset your password to Financial Component. If you did not make this request, please reach out to us immediately. Thank you.' + "\n" + "\n" + @current_user.password.to_s)      
    elsif @current_user.email_verified_at == nil
      subject = 'Financial Component Email Verification'
      content = Content.new(type: 'text/plain', value: 'Please see below for a code to verify your email with Financial Component. This code is valid for only 3 hours. Thank you.' + "\n" + "\n" + @current_user.user_verification.email_validation_code.to_s)
    end
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
  
  def verify_email_code
    validation_code = params.fetch("code").to_i
    user_verification = UserVerification.where(:user_id => @current_user.id).first

    if validation_code == user_verification.email_validation_code
      @current_user.email_verified_at = Time.now
      if @current_user.valid?
        @current_user.save
        if (@current_user.email_verified_at != nil) && (@current_user.mobile_verified_at != nil)
          user_verification.destroy_all
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end
  
  def add_mobile
    #render({ :template => "user_authentication/add_mobile.html.erb" })
  end

  def verify_mobile
    flag = 0
    recipient = params.fetch("recipient")
    if recipient[0] == ' '
      recipient[0] = '+'
      flag = 1
    end
        
    # Your Account Sid and Auth Token from twilio.com/console
    # and set the environment variables. See http://twil.io/secure
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    service = @client.verify.services.create(
                                        friendly_name: 'Financial Component'
                                      )

    # Download the helper library from https://www.twilio.com/docs/ruby/install
 
    verification = @client.verify
                          .services(service.sid)
                          .verifications
                          .create(to: recipient.gsub('-',''), channel: 'sms')

    session.store(:twilio_sid, verification.sid)
    session.store(:twilio_service_sid, verification.service_sid)

    @current_user.mobile = recipient
    if @current_user.valid?
      @current_user.save
    end

    user_verification = UserVerification.where({ :user_id => @current_user.id }).first
    if user_verification == nil
      user_verification = UserVerification.new
      user_verification.user_id =  @current_user.id
    end
    user_verification.mobile = recipient

    if user_verification.valid?
      user_verification.save 
    end

    @verification_stage = 0

    if flag == 0
      respond_to do |format|
        format.js
      end
    elsif flag == 1
      render({ :template => "user_authentication/add_mobile.html.erb" })
    end
  end

  def verify_mobile_code
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    verification_check = @client.verify
      .services(session.fetch('twilio_service_sid'))
      .verification_checks
      .create(verification_sid: session.fetch('twilio_sid'), code: params.fetch("code"))

    if verification_check.status == 'approved'
      @twilio_status = 'approved'
      phone_number = verification_check.to
      @current_user.mobile_verified_at = Time.now

      user_verification = UserVerification.where(:user_id => @current_user.id).first
      user_verification.mobile_verified_at = Time.now

        if @current_user.valid?
          @current_user.save
          if (@current_user.email_verified_at != nil) && (@current_user.mobile_verified_at != nil)
            user_verification.destroy
          end
        end
    end

    respond_to do |format|
      format.js
    end
  end

  def change_password
    #render({ :template => "user_authentication/change_password.html.erb" })
  end
  
  def verify_password
    current_password = params.fetch("curr")
    new_password = params.fetch("new")
    new_password_confirmation = params.fetch("confirm")

    password_legit = @current_user.authenticate(current_password)
    
    @succes = false
    if password_legit == false
      
    else
      @current_user.password = new_password
      @current_user.password_confirmation = new_password_confirmation
      @current_user.password_verified_at = Time.now

      if @current_user.valid?
        @current_user.save
        reset_session
        @success = true
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def forgot_password
    #render({ :template => "user_authentication/forgot_password.html.erb" })
  end

  def reset_password
    render({ :template => "user_authentication/reset_password.html.erb"})
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled." })
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
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update()
    p params.fetch("query_first_name")
    p params.fetch("query_last_name")
    p params.fetch("query_email")
    p params.fetch("query_password")
    p params.fetch("query_password_confirmation")
    p params.fetch("query_mobile")
    
    ##if @user.valid?
    ##  @user.save

    ##  redirect_to("/index", { :notice => "User account updated successfully."})
    ##else
    ##  render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    ##end
  end
end
