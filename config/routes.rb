Rails.application.routes.draw do
  #homepage
  get("/",{:controller=>"application", :action=>"index"})

  get("/test",{:controller=>"application", :action=>"test"})


end
