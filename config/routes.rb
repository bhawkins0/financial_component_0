Rails.application.routes.draw do
  #NAVBAR ROUTES
  get("/",{:controller=>"user_authentication", :action=>"sign_in"})
  get("/index",{:controller=>"application", :action=>"index"})
  get("/about",{:controller=>"application", :action=>"about"})
  get("/contact",{:controller=>"application", :action=>"contact"})  
  
  # LOGIN ROUTES
  get("/sign_in", { :controller => "user_authentication", :action => "sign_in" })
  post("/process_login_form", {:controller => "user_authentication", :action => "process_login_form"})
  get("/sign_up", { :controller => "user_authentication", :action => "sign_up" })
  post("/create_user", { :controller => "user_authentication", :action => "create_user"  })
  
  #SETTINGS ROUTES
  get("/settings/profile", { :controller => "user_authentication", :action => "get_user_profile" })
  
  get("/settings/add_email", { :controller => "user_authentication", :action => "add_email" })
  post("/validate_email", { :controller => "user_authentication", :action => "validate_email" })
  get("/verify_email", { :controller => "user_authentication", :action => "verify_email"  })
  post("/verify_email_code", { :controller => "user_authentication", :action => "verify_email_code"  })
  
  get("/settings/add_mobile", { :controller => "user_authentication", :action => "add_mobile" })
  get("/verify_mobile", { :controller => "user_authentication", :action => "verify_mobile" })
  post("/verify_mobile", { :controller => "user_authentication", :action => "verify_mobile" })
  post("/verify_mobile_code", { :controller => "user_authentication", :action => "verify_mobile_code" })

  get("/settings/change_password", { :controller => "user_authentication", :action => "change_password"})
  post("/verify_password", { :controller => "user_authentication", :action => "verify_password"})
  get("/forgot_password", { :controller => "user_authentication", :action => "forgot_password"})
  post("/reset_password", { :controller => "user_authentication", :action => "reset_password"})






 
  
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  
  
  # AUTHENTICATE AND STORE COOKIE
  #post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  

  





  # Routes for the User verification resource:

  # CREATE
  post("/insert_user_verification", { :controller => "user_verifications", :action => "create" })
          
  # READ
  get("/user_verifications", { :controller => "user_verifications", :action => "index" })
  
  get("/user_verifications/:path_id", { :controller => "user_verifications", :action => "show" })
  
  # UPDATE
  
  post("/modify_user_verification/:path_id", { :controller => "user_verifications", :action => "update" })
  
  # DELETE
  get("/delete_user_verification/:path_id", { :controller => "user_verifications", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component transaction split template resource:

  # CREATE
  ##post("/insert_financial_component_transaction_split_template", { :controller => "financial_component_transaction_split_templates", :action => "create" })
          
  # READ
  ##get("/financial_component_transaction_split_templates", { :controller => "financial_component_transaction_split_templates", :action => "index" })
  
  ##get("/financial_component_transaction_split_templates/:path_id", { :controller => "financial_component_transaction_split_templates", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_financial_component_transaction_split_template/:path_id", { :controller => "financial_component_transaction_split_templates", :action => "update" })
  
  # DELETE
  ##get("/delete_financial_component_transaction_split_template/:path_id", { :controller => "financial_component_transaction_split_templates", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component transaction split resource:

  # CREATE
  ##post("/insert_financial_component_transaction_split", { :controller => "financial_component_transaction_splits", :action => "create" })
          
  # READ
  ##get("/financial_component_transaction_splits", { :controller => "financial_component_transaction_splits", :action => "index" })
  
  ##get("/financial_component_transaction_splits/:path_id", { :controller => "financial_component_transaction_splits", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_financial_component_transaction_split/:path_id", { :controller => "financial_component_transaction_splits", :action => "update" })
  
  # DELETE
  ##get("/delete_financial_component_transaction_split/:path_id", { :controller => "financial_component_transaction_splits", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component account resource:

  # CREATE
  ##post("/insert_financial_component_account", { :controller => "financial_component_accounts", :action => "create" })
          
  # READ
  ##get("/financial_component_accounts", { :controller => "financial_component_accounts", :action => "index" })
  
  ##get("/financial_component_accounts/:path_id", { :controller => "financial_component_accounts", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_financial_component_account/:path_id", { :controller => "financial_component_accounts", :action => "update" })
  
  # DELETE
  ##get("/delete_financial_component_account/:path_id", { :controller => "financial_component_accounts", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component keyword resource:

  # CREATE
  ##post("/insert_financial_component_keyword", { :controller => "financial_component_keywords", :action => "create" })
          
  # READ
  ##get("/financial_component_keywords", { :controller => "financial_component_keywords", :action => "index" })
  
  ##get("/financial_component_keywords/:path_id", { :controller => "financial_component_keywords", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_financial_component_keyword/:path_id", { :controller => "financial_component_keywords", :action => "update" })
  
  # DELETE
  ##get("/delete_financial_component_keyword/:path_id", { :controller => "financial_component_keywords", :action => "destroy" })

  #------------------------------

  # Routes for the Financial component transaction resource:

  # CREATE
  ##post("/insert_financial_component_transaction", { :controller => "financial_component_transactions", :action => "create" })
          
  # READ
  ##get("/financial_component_transactions", { :controller => "financial_component_transactions", :action => "index" })
  
  ##get("/financial_component_transactions/:path_id", { :controller => "financial_component_transactions", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_financial_component_transaction/:path_id", { :controller => "financial_component_transactions", :action => "update" })
  
  # DELETE
  ##get("/delete_financial_component_transaction/:path_id", { :controller => "financial_component_transactions", :action => "destroy" })

  #------------------------------

  # Routes for the Plaid account resource:

  # CREATE
  ##post("/insert_plaid_account", { :controller => "plaid_accounts", :action => "create" })
          
  # READ
  ##get("/plaid_accounts", { :controller => "plaid_accounts", :action => "index" })
  
  ##get("/plaid_accounts/:path_id", { :controller => "plaid_accounts", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_plaid_account/:path_id", { :controller => "plaid_accounts", :action => "update" })
  
  # DELETE
  ##get("/delete_plaid_account/:path_id", { :controller => "plaid_accounts", :action => "destroy" })

  #------------------------------

  # Routes for the Plaid transaction resource:

  # CREATE
  ##post("/insert_plaid_transaction", { :controller => "plaid_transactions", :action => "create" })
          
  # READ
  ##get("/plaid_transactions", { :controller => "plaid_transactions", :action => "index" })
  
  ##get("/plaid_transactions/:path_id", { :controller => "plaid_transactions", :action => "show" })
  
  # UPDATE
  
  ##post("/modify_plaid_transaction/:path_id", { :controller => "plaid_transactions", :action => "update" })
  
  # DELETE
  ##get("/delete_plaid_transaction/:path_id", { :controller => "plaid_transactions", :action => "destroy" })

  #------------------------------

  
  
  


  #get("/test",{:controller=>"application", :action=>"test"})

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
