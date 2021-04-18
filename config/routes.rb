Rails.application.routes.draw do
  # Routes for the Financial component account resource:

  # CREATE
  post("/insert_financial_component_account", { :controller => "financial_component_accounts", :action => "create" })
          
  # READ
  get("/financial_component_accounts", { :controller => "financial_component_accounts", :action => "index" })
  
  get("/financial_component_accounts/:path_id", { :controller => "financial_component_accounts", :action => "show" })
  
  # UPDATE
  
  post("/modify_financial_component_account/:path_id", { :controller => "financial_component_accounts", :action => "update" })
  
  # DELETE
  get("/delete_financial_component_account/:path_id", { :controller => "financial_component_accounts", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component keyword resource:

  # CREATE
  post("/insert_financial_component_keyword", { :controller => "financial_component_keywords", :action => "create" })
          
  # READ
  get("/financial_component_keywords", { :controller => "financial_component_keywords", :action => "index" })
  
  get("/financial_component_keywords/:path_id", { :controller => "financial_component_keywords", :action => "show" })
  
  # UPDATE
  
  post("/modify_financial_component_keyword/:path_id", { :controller => "financial_component_keywords", :action => "update" })
  
  # DELETE
  get("/delete_financial_component_keyword/:path_id", { :controller => "financial_component_keywords", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component transaction resource:

  # CREATE
  post("/insert_financial_component_transaction", { :controller => "financial_component_transactions", :action => "create" })
          
  # READ
  get("/financial_component_transactions", { :controller => "financial_component_transactions", :action => "index" })
  
  get("/financial_component_transactions/:path_id", { :controller => "financial_component_transactions", :action => "show" })
  
  # UPDATE
  
  post("/modify_financial_component_transaction/:path_id", { :controller => "financial_component_transactions", :action => "update" })
  
  # DELETE
  get("/delete_financial_component_transaction/:path_id", { :controller => "financial_component_transactions", :action => "destroy" })

  #------------------------------

  # Routes for the Plaid account resource:

  # CREATE
  post("/insert_plaid_account", { :controller => "plaid_accounts", :action => "create" })
          
  # READ
  get("/plaid_accounts", { :controller => "plaid_accounts", :action => "index" })
  
  get("/plaid_accounts/:path_id", { :controller => "plaid_accounts", :action => "show" })
  
  # UPDATE
  
  post("/modify_plaid_account/:path_id", { :controller => "plaid_accounts", :action => "update" })
  
  # DELETE
  get("/delete_plaid_account/:path_id", { :controller => "plaid_accounts", :action => "destroy" })

  #------------------------------

  # Routes for the Plaid transaction resource:

  # CREATE
  post("/insert_plaid_transaction", { :controller => "plaid_transactions", :action => "create" })
          
  # READ
  get("/plaid_transactions", { :controller => "plaid_transactions", :action => "index" })
  
  get("/plaid_transactions/:path_id", { :controller => "plaid_transactions", :action => "show" })
  
  # UPDATE
  
  post("/modify_plaid_transaction/:path_id", { :controller => "plaid_transactions", :action => "update" })
  
  # DELETE
  get("/delete_plaid_transaction/:path_id", { :controller => "plaid_transactions", :action => "destroy" })

  #------------------------------

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

  #SETTINGS
  get("/settings/profile", { :controller => "user_authentication", :action => "get_user_profile" })
  get("/settings/add_mobile", { :controller => "user_authentication", :action => "add_mobile" })
  post("/validate_mobile", { :controller => "user_authentication", :action => "validate_mobile" })
  post("/validate_mobile_code", { :controller => "user_authentication", :action => "validate_mobile_code" })
  # ------------------------------

  # SIGN IN FORM
  get("/sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  #post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  #NAVBAR ROUTES
  get("/",{:controller=>"application", :action=>"index"})
  get("/about",{:controller=>"application", :action=>"about"})
  get("/contact",{:controller=>"application", :action=>"contact"})

  get("/test",{:controller=>"application", :action=>"test"})

  #PLAID ROUTES
  get("/plaid", {:controller=>"plaid_link",:action=>"plaid_index"})
  get("/connect_with_plaid", {:controller=>"plaid_link",:action=>"connect_with_plaid"})
  post("/create_link_token",{:controller=>"plaid_link",:action=>"create_link_token"})
  post("/get_access_token",{:controller=>"plaid_link",:action=>"get_access_token"})
  get("/get_transactions",{:controller=>"plaid_link",:action=>"get_transactions"})
  get("/plaid/:the_institution",{:controller=>"plaid_link",:action=>"get_institution"})
  post("/plaid/save_account",{:controller=>"plaid_link",:action=>"save_account"})
  get("/commit_audit/:the_institution",{:controller=>"plaid_link",:action=>"commit_audit"})
  post("/plaid/get_commit",{:controller=>"plaid_link",:action=>"get_commit"})
end
