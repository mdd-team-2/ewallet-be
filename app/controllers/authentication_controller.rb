class AuthenticationController < ApplicationController
  
  def login
    command = AuthenticateCommand.call(params[:user][:email],params[:user][:password])
    if command.success?
      user = User.by_email(params[:user][:email])
      render json: {
        data: {
          token: command.result,
          name: user.name + " " + user.lastname,
          type: user.role.id
        }
      }, status: :ok
    else
      render json: {
        data: {
          errors: {
            message: "Invalid credentials"
          }
        }
      }, status: :unauthorized
    end 
  end

end
