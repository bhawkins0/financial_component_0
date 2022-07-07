class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie, :process_login_form, :reset_password, :validate_password_reset, :validate_email, :validate_mobile, :validate_mobile_code, :update_password, :about, :contact] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def process_login_form
    a = params.fetch("subject")
    b = params.fetch("query_email_mobile")
    c = params.fetch("query_password")
    if a == "Log In"
      create_cookie(b,c)
    else
      redirect_to("/sign_up")
    end
  end

  def create_cookie(uname,pwd)
    user = User.where({ :email => uname }).first

    if user == nil
      if uname.length >= 10
        user = User.where('mobile LIKE ?','%' + uname).first
      end
    end

    the_supplied_password = pwd
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/sign_in", { :alert => "Incorrect login information." })
      else

        #INSERT MFA CODE HERE

        session[:user_id] = user.id
        
        redirect_to("/index", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/sign_in", { :alert => "No user with that email address." })
    end
  end

  def validate_email
    email_exists = User.where({ :email => params.fetch("query_email") }).first
    
    session[:email] = params.fetch("query_email")

    if email_exists == nil
      @email_exists = 0
    else 
      @email_exists = 1
    end
    
    flags = params.fetch("flags").to_i
    @flags = flags
    
    if flags == 1
      if email_exists == nil 
        #create
        
        UserVerification.where(:email => params.fetch("query_email")).destroy_all

        email_code

        user_verification = UserVerification.new
        user_verification.user_id =  @current_user.id
        user_verification.email = params.fetch("query_email")
        user_verification.email_validation_code = session[:email_code]

        if user_verification.valid?
          user_verification.save
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def verify_email
    render({ :template => "user_authentication/verify_email.html.erb" })
  end



  def validate_mobile
    recipient = params.fetch("recipient")
    @flags = params.fetch("flags").to_i

    mobile_exists = User.where({ :mobile => params.fetch("query_mobile") }).first

    if @flags == 0
      if mobile_exists == nil
        @mobile_exists = 2

        respond_to do |format|
          format.js
        end
      end
    elsif @flags == 1
      if mobile_exists != nil
        @mobile_exists = 2

        respond_to do |format|
          format.js
        end
      end
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

    @verification_stage = 1

    user_verification = UserVerification.where({ :mobile => recipient }).first
    if user_verification == nil
      user_verification = UserVerification.new
      user_verification.user_id =  0
    end
    user_verification.mobile = recipient

    if user_verification.valid?
      user_verification.save 
    end

    respond_to do |format|
      format.js
    end
  end







  def create_user()
    user = User.new
    user.first_name = params.fetch("query_first_name")
    user.last_name = params.fetch("query_last_name")
    user.password = params.fetch("query_password")
    user.password_confirmation = params.fetch("query_password_confirmation")
    user.email = params.fetch("query_email")
    user.mobile = params.fetch("query_mobile")
    if params.fetch("query_email") != nil
      user.email_verified_at = DateTime.now
    end
    if params.fetch("query_mobile") != nil
      user.mobile_verified_at = DateTime.now
    end

    save_status = user.save

    if save_status == true
      session[:user_id] = user.id
      @current_user = user
      #redirect_to("/index", { :notice => "User account created successfully."})
      #else
      #redirect_to("/sign_up", { :alert => "User account failed to create successfully."})
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

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled." })
  end
 
  def get_user_profile
    render({ :template => "user_authentication/user_settings.html.erb" })
  end

  def add_mobile
    render({ :template => "user_authentication/add_mobile.html.erb" })
  end

  def add_email
    render({ :template => "user_authentication/add_email.html.erb" })
  end

  def validate_mobile_code
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
      #p phone_number
      @flags = params.fetch("flags").to_i
      if @flags == 0
        @current_user.mobile = phone_number
        if @current_user.valid?
          @current_user.save
        end
      elsif @flags == 1
        user_verification = UserVerification.where({ :mobile => phone_number }).first
        user_verification.mobile_verified_at = DateTime.now
        #NEED TO UPDATE THIS to inlcude mobile_verified_at
        if user_verification.valid?
          user_verification.save
        end

        create
      end
    end

    respond_to do |format|
      format.js
    end
  end

  include SendGrid
  def email_code
    # using SendGrid's Ruby Library
    # https://github.com/sendgrid/sendgrid-ruby

    session[:email_code] = rand(1000..9999)
    
    from = Email.new(email: 'brennan@financialcomponent.com')
    to = Email.new(email: session[:email])
    if @flags == 0
      subject = 'Financial Component Password Reset'
      content = Content.new(type: 'text/plain', value: 'Please see below for a validation code to reset your password to Financial Component. If you did not make this request, please reach out to us immediately. Thank you.' + "\n" + "\n" + session[:email_code].to_s)
    elsif @flags == 1
      subject = 'Financial Component Email Verification'
      content = Content.new(type: 'text/plain', value: 'Please see below for a code to verify your email with Financial Component. This code is valid for only 3 hours. Thank you.' + "\n" + "\n" + session[:email_code].to_s)
    end
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers

    if @flags == 0
      render({ :template => "user_authentication/reset_password.html.erb" })
    end
  end

  def validate_email_code
    @verification_stage = 1

    if params.fetch("code") == session[:vCode].to_s
      session.delete(:vCode)

      @password_reset_status = 1
      
    else
        respond_to do |format|
          format.js
        end
    end
  end

  def update_password
    @user = User.where({ :email => session[:email] }).first
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
  
    if @user.valid?
      @user.save

      reset_session
      
      redirect_to("/index", { :notice => "User account updated successfully."})
    end
  end
end
