class UserVerificationsController < ApplicationController
  def index
    matching_user_verifications = UserVerification.all

    @list_of_user_verifications = matching_user_verifications.order({ :created_at => :desc })

    render({ :template => "user_verifications/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_user_verifications = UserVerification.where({ :id => the_id })

    @the_user_verification = matching_user_verifications.at(0)

    render({ :template => "user_verifications/show.html.erb" })
  end

  def create
    the_user_verification = UserVerification.new
    the_user_verification.user_id = params.fetch("query_user_id")
    the_user_verification.email = params.fetch("query_email")
    the_user_verification.email_validation_code = params.fetch("query_email_validation_code")
    the_user_verification.mobile = params.fetch("query_mobile")
    the_user_verification.mobile_validation_code = params.fetch("query_mobile_validation_code")

    if the_user_verification.valid?
      the_user_verification.save
      redirect_to("/user_verifications", { :notice => "User verification created successfully." })
    else
      redirect_to("/user_verifications", { :notice => "User verification failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user_verification = UserVerification.where({ :id => the_id }).at(0)

    the_user_verification.user_id = params.fetch("query_user_id")
    the_user_verification.email = params.fetch("query_email")
    the_user_verification.email_validation_code = params.fetch("query_email_validation_code")
    the_user_verification.mobile = params.fetch("query_mobile")
    the_user_verification.mobile_validation_code = params.fetch("query_mobile_validation_code")

    if the_user_verification.valid?
      the_user_verification.save
      redirect_to("/user_verifications/#{the_user_verification.id}", { :notice => "User verification updated successfully."} )
    else
      redirect_to("/user_verifications/#{the_user_verification.id}", { :alert => "User verification failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user_verification = UserVerification.where({ :id => the_id }).at(0)

    the_user_verification.destroy

    redirect_to("/user_verifications", { :notice => "User verification deleted successfully."} )
  end
end
