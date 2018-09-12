class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])

    # if( user && user.valid_password?(sign_in_params[:password]) )
    if( current_user )
      render json: {"yah": "good"}
    else
      render json: {"nah": "bad"}
    end

  end
end