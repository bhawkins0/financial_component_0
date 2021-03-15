class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  before_action(:force_user_sign_in)
  
 # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:about, :contact] })

  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
    if @current_user != nil
      @matching_institutions = @current_user.institutions
    end
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/sign_in", { :notice => "Please sign in or register." })
    end
  end

  def index
    render("/index.html.erb")
  end

  def about
    render("/about.html.erb")
  end

  def contact
    render("/contact.html.erb")
  end

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)

    if results.present?
      return results
    else
      return nil
    end
  end
end
