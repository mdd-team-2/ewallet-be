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

  def authenticate_user(authentication:)
    puts "---------esta es la autenticacion del usuario--------"
    puts authentication

    render json: {
              data: {
                token: 'estoesuntokenrevalidodeusuario'
              }
            }, status: 200
    
  end

  def authenticate_admin(authentication:)

    puts "---------esta es la autenticacion del tendero--------"
    puts authentication

    render json: {
      data: {
        token: 'estoesuntokenrevalidodetendero'
      }
    }, status: 200
    
  end

end
