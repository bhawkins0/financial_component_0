class ApplicationController < ActionController::Base
  def index
    render("/index.html.erb")
  end


  def test
    render("/test.html.erb")
  end
end
