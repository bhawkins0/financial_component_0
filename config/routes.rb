Rails.application.routes.draw do
  # Routes for the User account:
  # LOGIN FORM
  post("/process_login_form", {:controller => "user_authentication", :action => "process_login_form"})

  # SIGN UP FORM
  get("/sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  #post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  #NAVBAR ROUTES
  
  get("/about",{:controller=>"application", :action=>"about"})
  get("/contact",{:controller=>"application", :action=>"contact"})

  get("/test",{:controller=>"application", :action=>"test"})

  #PLAID ROUTES
  get("/",{:controller=>"plaid_link", :action=>"index"})
  #get("/plaid/api/transactions",{:controller=>"plaid_link",:action=>"get_transactions"})
  ##get("/connect_with_plaid", {:controller=>"plaid",:action=>"connect_with_plaid"})
  
end
