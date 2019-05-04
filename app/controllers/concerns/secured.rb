module Secured
  extend ActiveSupport::Concern
  attr_reader :current_user,:current_admin,:token

  def authenticate!
    begin
      obj = auth_token

      # @current_admin = Admin.by_id(obj[:id])
      # unless @current_admin
      #   raise JWT::VerificationError
      # end
      @current_user = nil
      generate_token @current_user

    rescue JWT::VerificationError, JWT::DecodeError
      response_message
    end
  end
  

  private
  def generate_token(object)
    @token = JsonWebToken.encode(playload: {id: 1,type: 1})
  end
  
  def response_message
    render json: {
      data: {
        errors: ['Not authorized']
      }
    }, status: :unauthorized
  end

  def auth_token
    JsonWebToken.decode(http_token)  
  end

  def http_token
    if request.headers['Authorization'].present?
      values = request.headers['Authorization'].split(" ")
      if values[0] == 'Bearer'
        return values.last
      else  
        return nil
      end
    end
    nil
  end
end